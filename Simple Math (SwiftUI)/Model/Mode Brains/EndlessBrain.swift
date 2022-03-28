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
    private var difficulty:Int = 1
    private var currentRegular:equation?
    private var currentSquare:squares?
    private var correct = 0
    private var incorrect = 0
    private var withHint = 0
    private var start:UInt64
    private var operation = 0
    private var numberOne = 0
    private var numberTwo = 0
    private var valid = false
    private var hints = 0
    private var hintUsed = false
    private var display:String = ""
    
    init(){
        start = DispatchTime.now().uptimeNanoseconds
        questionText = nextQuestion()
    }
    
    // MARK: PUBLIC FUNCTIONS
    public func setDifficulty(_ diff: Int){
        reset()
        difficulty = diff
        questionText = nextQuestion()
        streakLarge = defaults.integer(forKey: keysEndless[difficulty])
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
        defaults.set(streakLarge, forKey: keysEndless[difficulty])
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
                    defaults.set(streakLarge, forKey: keysEndless[difficulty])
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
        case 0: return easyQuestion()
        case 1: return mediumQuestion()
        case 2: return hardQuestion()
        case 3: return squareQuestion()
        case 4: return extremeQuestion()
        default: return easyQuestion()
        }
    }
    
    // MARK: QUESTION GENERATION
    //Generates questions with the parameters defined in the random based on difficulty/type
    private func easyQuestion() -> String{
        operation = Int.random(in: 0...3)
        if (operation == 0){
            numberOne = Int.random(in: 1...50)
            numberTwo = Int.random(in: 1...50)
        } else if (operation == 1){
            numberOne = Int.random(in: 1...50)
            numberTwo = Int.random(in: 1...numberOne)
        } else if (operation == 2){
            numberOne = Int.random(in: 1...8)
            numberTwo = Int.random(in: 1...8)
        } else{
            numberOne = Int.random(in: 1...8)
            valid = false
            while !valid {
                numberTwo = Int.random(in: 1...8)
                if (numberOne % numberTwo == 0){
                    valid = true
                }
            }
        }
        currentRegular = equation.init(operation: operation, numberOne: numberOne, numberTwo: numberTwo)
        currentSquare = nil
        return currentRegular!.display
    }
    
    private func mediumQuestion() -> String{
        operation = Int.random(in: 0...3)
        if (operation == 0){
            numberOne = Int.random(in: 51...250)
            numberTwo = Int.random(in: 51...250)
        } else if (operation == 1){
            numberOne = Int.random(in: 51...250)
            numberTwo = Int.random(in: 51...numberOne)
        } else if (operation == 2){
            numberOne = Int.random(in: 9...12)
            numberTwo = Int.random(in: 9...12)
        } else{
            numberOne = Int.random(in: 9...12)
            valid = false
            while !valid {
                numberTwo = Int.random(in: 1...6)
                if (numberOne % numberTwo == 0){
                    valid = true
                }
            }
        }
        currentRegular = equation.init(operation: operation, numberOne: numberOne, numberTwo: numberTwo)
        currentSquare = nil
        return currentRegular!.display
    }
    
    private func hardQuestion() -> String{
        operation = Int.random(in: 0...3)
        if (operation == 0){
            numberOne = Int.random(in: 251...999)
            numberTwo = Int.random(in: 251...999)
        } else if (operation == 1){
            numberOne = Int.random(in: 251...999)
            numberTwo = Int.random(in: 251...numberOne)
        } else if (operation == 2){
            numberOne = Int.random(in: 13...25)
            numberTwo = Int.random(in: 13...25)
        } else{
            numberOne = Int.random(in: 13...25)
            valid = false
            while !valid {
                numberTwo = Int.random(in: 1...12)
                if (numberOne % numberTwo == 0){
                    valid = true
                }
            }
        }
        currentRegular = equation.init(operation: operation, numberOne: numberOne, numberTwo: numberTwo)
        currentSquare = nil
        return currentRegular!.display
    }
    
    private func squareQuestion() -> String{
        operation = Int.random(in: 0...1)
        let number = Int.random(in: 1...25)
        if (operation == 0){
            currentSquare = squares.init(operation: operation, numberOne: (number*number))
        } else {
            currentSquare = squares.init(operation: operation, numberOne: number)
        }
        currentRegular = nil
        return currentSquare!.display
    }
    
    private func extremeQuestion() -> String{
        operation = Int.random(in: 0...5)
        let number = Int.random(in: 1...25)
        var text: String
        if (operation == 0){
            currentSquare = squares.init(operation: operation, numberOne: (number*number))
            currentRegular = nil
            text = currentSquare!.display
        } else if (operation == 1){
            currentSquare = squares.init(operation: operation, numberOne: number)
            currentRegular = nil
            text = currentSquare!.display
        } else {
            if (operation == 2){
                numberOne = Int.random(in: 251...999)
                numberTwo = Int.random(in: 251...999)
            } else if (operation == 3){
                numberOne = Int.random(in: 251...999)
                numberTwo = Int.random(in: 251...numberOne)
            } else if (operation == 4){
                numberOne = Int.random(in: 13...25)
                numberTwo = Int.random(in: 13...25)
            } else{
                numberOne = Int.random(in: 13...25)
                valid = false
                while !valid {
                    numberTwo = Int.random(in: 1...12)
                    if (numberOne % numberTwo == 0){
                        valid = true
                    }
                }
            }
            currentRegular = equation.init(operation: (operation-2), numberOne: numberOne, numberTwo: numberTwo)
            currentSquare = nil
            text = currentRegular!.display
        }
        return text
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
