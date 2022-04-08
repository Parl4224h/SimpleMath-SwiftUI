//
//  MaxBrain.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/24/22.
//

import Foundation
import SwiftUI

final class MaxBrain: ObservableObject {
    // MARK: PUBLISHED VARIABLES
    @Published var timeElapsed: Int = 0
    @Published var answerText: String = ""
    @Published var percentCorrect: Float = 0.0
    @Published var streakSmall: Int = 0
    @Published var streakLarge: Int = 0
    @Published var totalQuestionsSmall: Int = 0
    @Published var totalQuestionsLarge: Int = 0
    @Published var questionText: String = ""
    @Published var answerColor: SwiftUI.Color = SwiftUI.Color.black
    @Published var answerTextColor: SwiftUI.Color = SwiftUI.Color.white
    @Published var difficulty: Difficulty = .easy
    @Published var isVisible: Bool = false
    @Published var isOver: Bool = false
    @Published var endVisible: Bool = false
    @Published var recordTime: Int = 0
    @Published var longStreak: Int = 0
    
    // MARK: PRIVATE VARIABLES
    private var currentRegular:equation?
    private var currentSquare:squares?
    private var correct = 0
    private var incorrect = 0
    private var withHint = 0
    private var hints = 0
    private var hintUsed = false
    private var display: String = ""
    private var totalQuestions = 0
    private var elapsedQuestions = 0
    private var modelData = ModelData()
    private var generation = QuestionGeneration()
    private var diffInt = 0
    private var qInt = 0
    
    
    init() {
        questionText = nextQuestion()
    }
    
    // MARK: PUBLIC FUNCTIONS

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
    
    public func closeEndScreen() {
        endVisible = false
    }
    
    public func Submit() {
        if isOver {
            questionText = nextQuestion()
            reset()
            isOver = false
            answerText = ""
        }else{
            checkAnswer()
        }
    }
    
    public func gameOver() {
        questionText = "Press Submit to Play Again"
        isOver = true
        endVisible = true
    }
    
    public func viewAppear(questionNumber: Int) {
        totalQuestions = questionNumber
        elapsedQuestions = 0
        reset()
        isVisible = true
        isOver = false
        switch(difficulty){
        case Difficulty.easy: diffInt = 0
        case Difficulty.medium: diffInt = 1
        case Difficulty.hard: diffInt = 2
        case Difficulty.squares: diffInt = 3
        case Difficulty.extreme: diffInt = 4
        }
        switch(questionNumber) {
        case 3: qInt = 0
        case 5: qInt = 1
        case 10: qInt = 2
        case 15: qInt = 3
        case 20: qInt = 4
        case 25: qInt = 5
        default: qInt = 0
        }
        streakLarge = modelData.maxBests[diffInt + (5*qInt)]
        questionText = nextQuestion()
    }
    
    public func viewDisappear() {
        reset()
        timeElapsed = 0
        isVisible = false
        questionText = nextQuestion()
    }

    
    // MARK: PRIVATE FUNCTIONS
    private func checkAnswer() {
        var remaining = 0.25
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
                elapsedQuestions += 1
                if (hintUsed){
                    withHint += 1
                } else{
                    correct += 1
                    streakSmall += 1
                }
                if(streakSmall > streakLarge){
                    streakLarge = streakSmall
                    modelData.maxBests[qInt + (5 * diffInt)] = streakLarge
                    modelData.saveMax()
                }
                if(streakSmall > longStreak) {
                    longStreak = streakSmall
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
                hints = 0
                hintUsed = false
                totalQuestionsSmall = correct
                totalQuestionsLarge = correct + incorrect + withHint
                percentCorrect = Float(correct) / Float(correct+incorrect+withHint)
                if (elapsedQuestions == totalQuestions) {
                    isOver = true
                    endVisible = true
                    questionText = "Press Submit to Play Again"
                } else {
                    display = ""
                    questionText = nextQuestion()
                }
            } else {
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
            }
        }
    }
    
    private func reset() {
        correct = 0
        incorrect = 0
        withHint = 0
        hints = 0
        hintUsed = false
        streakSmall = 0
        totalQuestionsSmall = 0
        totalQuestionsLarge = 0
        percentCorrect = 0.0
        streakLarge = 0
        timeElapsed = 0
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
