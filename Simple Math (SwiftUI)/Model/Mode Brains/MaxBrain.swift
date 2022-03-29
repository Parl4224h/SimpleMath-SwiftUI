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
    @Published var currentCorrectSmall: Int = 0
    @Published var currentCorrecLarge: Int = 0
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
    
    // MARK: PRIVATE VARIABLES
    private var currentRegular:equation?
    private var currentSquare:squares?
    private var correct = 0
    private var incorrect = 0
    private var withHint = 0
    private var operation = 0
    private var numberOne = 0
    private var numberTwo = 0
    private var valid = false
    private var hints = 0
    private var hintUsed = false
    private var display: String = ""
    private var totalQuestions = 0
    private var elapsedQuestions = 0
    
    
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
                    currentCorrectSmall += 1
                }
                if(currentCorrectSmall > currentCorrecLarge){
                    currentCorrecLarge = currentCorrectSmall
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
                print(totalQuestions)
                print(elapsedQuestions)
                if (elapsedQuestions == totalQuestions) {
                    isOver = true
                    endVisible = true
                    questionText = "Press Submit to Play Again"
                } else {
                    display = ""
                    questionText = nextQuestion()
                }
            } else {
                currentCorrectSmall = 0
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
        currentCorrectSmall = 0
        totalQuestionsSmall = 0
        totalQuestionsLarge = 0
        percentCorrect = 0.0
        //defaults.set(streakLarge, forKey: keys[difficulty])
        currentCorrecLarge = 0
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
