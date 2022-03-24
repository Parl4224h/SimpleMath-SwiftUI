//
//  Equation.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/14/22.
//

import Foundation

struct equation{
    let operation: Int //0: add, 1: sub, 2: mult, 3: div
    let numberOne: Int
    let numberTwo: Int
    let answer: Int
    let display: String
    
    init(operation o:Int, numberOne n1:Int, numberTwo n2:Int) {
        operation = o
        numberOne = n1
        numberTwo = n2
        var displayOp:String
        switch(o){
        case 0:
            answer = n1+n2
            displayOp = " + "
        case 1:
            answer = n1-n2
            displayOp = " - "
        case 2:
            answer = n1*n2
            displayOp = " * "
        case 3:
            answer = n1/n2
            displayOp = " / "
        default:
            answer = -1
            displayOp = " Something Went Wrong "
        }
        display = String(n1) + displayOp + String(n2) + " = ?"
    }
}

struct squares{
    let operation: Int //0: sqrt, 1: sq
    let number: Int
    let answer: Int
    let display:String
    init(operation o:Int, numberOne n:Int) {
        operation = o
        number = n
        if (operation==0){
            answer = Int(floor(Double(n).squareRoot()))
            display = "What is the Square root of: " + String(n) + "?"
        } else{
            answer = n*n
            display = "What is " + String(n) + " squared?"
        }
    }
}
