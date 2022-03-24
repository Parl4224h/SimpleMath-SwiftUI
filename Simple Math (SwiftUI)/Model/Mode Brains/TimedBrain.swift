//
//  TimedBrain.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/24/22.
//

import Foundation
import SwiftUI

final class TimedBrain: ObservableObject {
    // MARK: PUBLISHED VARIABLES
    @Published var timeRemaining = 10
    @Published var answerText = ""
    @Published var percentCorrect: Float = 0.0
    @Published var streakSmall: Int = 0
    @Published var streakLarge: Int = 0
    @Published var correctSmall: Int = 0
    @Published var correctLarge: Int = 0
    @Published var questionText: String = ""
    @Published var answerColor = SwiftUI.Color.black
    @Published var answerTextColor = SwiftUI.Color.white
    @Published var difficulty: Difficulty = .easy
    
    // MARK: PRIVATE VARIABLES
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
    
    init() {
        start = DispatchTime.now().uptimeNanoseconds
        questionText = nextQuestion()
    }
    
    // MARK: PUBLIC FUNCTIONS
    public func setDifficulty(_ diff: Difficulty){
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
    
    public func Submit() {
        checkAnswer()
    }
    
    public func endGame() {
        print("HERE")
    }
    
    public func setTimer(_ time: Int) {
        reset()
        timeRemaining = time
        questionText = nextQuestion()
        //streakLarge = defaults.integer(forKey: keys[difficulty + 5])
    }
    
    // MARK: PRIVATE FUNCTIONS
    private func checkAnswer() {
        
    }
    
    private func reset() {
        correct = 0
        incorrect = 0
        withHint = 0
        streakSmall = 0
        correctSmall = 0
        correctLarge = 0
        percentCorrect = 0.0
        //defaults.set(streakLarge, forKey: keys[difficulty])
        streakLarge = 0
        start = DispatchTime.now().uptimeNanoseconds
        timeRemaining = 0
    }
    
    private func nextQuestion() -> String {
        switch(difficulty) {
//        case 0: return easyQuestion()
//        case 1: return mediumQuestion()
//        case 2: return hardQuestion()
//        case 3: return squareQuestion()
//        case 4: return extremeQuestion()
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
