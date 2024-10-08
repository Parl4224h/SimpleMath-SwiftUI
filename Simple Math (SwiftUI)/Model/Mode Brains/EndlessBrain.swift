//
//  EndlessBrain.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/16/22.
//

import Foundation
import SwiftUI

final class EndlessBrain: ObservableObject {
    // MARK: PUBLISHED VARIABLES
    @Published var responseTime = 0
    @Published var answerText = ""
    @Published var percentCorrect: Float = 0.0
    @Published var streakSmall: Int = 0
    @Published var streakLarge: Int = 0
    @Published var correctSmall: Int = 0
    @Published var correctLarge: Int = 0
    @Published var questionText: String = ""
    @Published var answerColor = SwiftUI.Color.black
    @Published var answerTextColor = SwiftUI.Color.white
    
    // MARK: PRIVATE VARIABLES
    private var currentRegular:equation?
    private var currentSquare:squares?
    private var correct = 0
    private var incorrect = 0
    private var withHint = 0
    private var start:UInt64
    private var hints = 0
    private var hintUsed = false
    private var display:String = ""
    private var modelData = ModelData()
    private var generation = QuestionGeneration()
    private var diffInt = 0
    private var difficulty: Difficulty = Difficulty.easy
    
    init(){
        start = DispatchTime.now().uptimeNanoseconds
        questionText = nextQuestion()
    }
    
    // MARK: PUBLIC FUNCTIONS
    public func setDifficulty(_ diff: Difficulty) {
        difficulty = diff
    }
    
    public func Hint() {
        answerText = useHint()
        var remaining = 2.0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){(Timer) in
            if(remaining <= 0){
                self.answerText = ""
                Timer.invalidate()
            } else{
                remaining -= 0.25
            }
        }
    }
    
    public func viewAppear() {
        reset()
        switch(difficulty){
        case Difficulty.easy: diffInt = 0
        case Difficulty.medium: diffInt = 1
        case Difficulty.hard: diffInt = 2
        case Difficulty.squares: diffInt = 3
        case Difficulty.extreme: diffInt = 4
        }
        questionText = nextQuestion()
        streakLarge = modelData.endlessBests[diffInt]
    }
    
    public func viewDisappear() {
        reset()
        questionText = nextQuestion()
    }
    
    public func Submit() {
        checkAnswer()
    }
    
    // MARK: PRIVATE FUNCTIONS
    private func reset() {
        correct = 0
        incorrect = 0
        withHint = 0
        streakSmall = 0
        correctSmall = 0
        correctLarge = 0
        percentCorrect = 0.0
        streakLarge = 0
        start = DispatchTime.now().uptimeNanoseconds
        responseTime = 0
    }
    
    private func checkAnswer(){
        var remaining = 1.0
        let a = Int(answerText) ?? -1
        let ans:Int
        if (a == -1){
            answerText = "Invalid Answer"
            answerColor = SwiftUI.Color.yellow
            answerTextColor = SwiftUI.Color.black
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){(Timer) in
                if(remaining <= 0){
                    self.answerText = ""
                    Timer.invalidate()
                    self.answerColor = SwiftUI.Color.black
                    self.answerTextColor = SwiftUI.Color.white
                } else{
                    remaining -= 0.25
                }
            }
        }else{
            if (currentRegular != nil){
                ans = currentRegular!.answer
            } else {
                ans = currentSquare!.answer
            }
            if (a == ans){
                if (hintUsed){
                    withHint += 1
                    correct += 1
                } else{
                    correct += 1
                    streakSmall += 1
                }
                if(streakSmall > streakLarge){
                    streakLarge = streakSmall
                    modelData.endlessBests[diffInt] = streakLarge
                    modelData.saveEndless()
                }
                answerText = "Correct"
                answerColor = SwiftUI.Color.green
                answerTextColor = SwiftUI.Color.black
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){(Timer) in
                    if(remaining <= 0){
                        Timer.invalidate()
                        self.answerText = ""
                        self.answerColor = SwiftUI.Color.black
                        self.answerTextColor = SwiftUI.Color.white
                    } else{
                        remaining -= 0.25
                    }
                }
                display = ""
                hints = 0
                hintUsed = false
                responseTime = Int(DispatchTime.now().uptimeNanoseconds - start) / ((correct + incorrect) * 1000000000)
                correctSmall = correct
                correctLarge = correct + incorrect
                percentCorrect = (Float(correct) - (Float(withHint)/2.0)) / Float(correct+incorrect)
                questionText = nextQuestion()
            } else{
                incorrect += 1
                streakSmall = 0
                answerText = "Incorrect"
                answerColor = SwiftUI.Color.red
                answerTextColor = SwiftUI.Color.black
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){(Timer) in
                    if(remaining <= 0){
                        self.answerText = ""
                        self.answerColor = SwiftUI.Color.black
                        self.answerTextColor = SwiftUI.Color.white
                        Timer.invalidate()
                    } else{
                        remaining -= 0.25
                    }
                }
                display = ""
                hints = 0
                hintUsed = false
                responseTime = Int(DispatchTime.now().uptimeNanoseconds - start) / ((correct + incorrect) * 1000000000)
                correctSmall = correct
                correctLarge = correct + incorrect
                percentCorrect = (Float(correct) - (Float(withHint)/2.0)) / Float(correct+incorrect)
                questionText = nextQuestion()
            }
        }
    }
    
    
    
    private func nextQuestion() -> String {
        switch(difficulty) {
        case Difficulty.easy: return easyQuestion()
        case Difficulty.medium: return mediumQuestion()
        case Difficulty.hard: return hardQuestion()
        case Difficulty.squares: return squareQuestion()
        case Difficulty.extreme: return extremeQuestion()
        }
    }
    
    private func easyQuestion() -> String{
        currentSquare = nil
        currentRegular = generation.easyQuestion()
        return currentRegular!.display
    }
    
    private func mediumQuestion() -> String{
        currentSquare = nil
        currentRegular = generation.mediumQuestion()
        return currentRegular!.display
    }
    
    private func hardQuestion() -> String{
        currentSquare = nil
        currentRegular = generation.hardQuestion()
        return currentRegular!.display
    }
    
    private func squareQuestion() -> String{
        currentRegular = nil
        currentSquare = generation.squareQuestion()
        return currentSquare!.display
    }
    
    private func extremeQuestion() -> String{
        if (Int.random(in: 0...1) == 0){
            currentSquare = nil
            currentRegular = generation.hardQuestion()
            return currentRegular!.display
        } else {
            currentRegular = nil
            currentSquare = generation.squareQuestion()
            return currentSquare!.display
        }
    }
    
    private func useHint() -> String{
        hints += 1
        hintUsed = true
        var ans:Int
        var i = 0
        if (currentRegular != nil){
            ans = currentRegular!.answer
        } else {
            ans = currentSquare!.answer
        }
        var reverse = 0
        let ansLength = String(ans).count
        while (ans != 0) {
            reverse = reverse * 10
            reverse = reverse + ans % 10
            ans = ans / 10
        }
        if hints <= ansLength{
            display = ""
            while i<hints {
                display.append(String(reverse%10))
                reverse /= 10
                i+=1
            }
            i = 0
            while i<(ansLength-hints){
                display.append("X")
                i+=1
            }
            
        }
        return display
    }
}
