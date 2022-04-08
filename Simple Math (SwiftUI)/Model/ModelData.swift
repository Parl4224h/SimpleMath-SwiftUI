//
//  MaxModel.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/29/22.
//

import Foundation

enum Difficulty: String, CaseIterable, Identifiable {
    case easy
    case medium
    case hard
    case squares
    case extreme
    var id: Self { self }
}

enum Times: Int, CaseIterable, Identifiable {
    case ten = 10
    case twenty = 20
    case thirty = 30
    case forty = 40
    case fifty = 50
    case sixty = 60
    var id: Self { self }
}

enum Questions: Int, CaseIterable, Identifiable {
    case three = 3
    case five = 5
    case ten = 10
    case fifteen = 15
    case twenty = 20
    case twentyFive = 25
    var id: Self { self }
}

final class ModelData: ObservableObject {
    @Published var maxBests: [Int] = load("maxData")
    @Published var timedBests: [Int] = load("timedData")
    @Published var endlessBests: [Int] = load("endlessData")
    
    private let manager = FileManager.default
    
    func saveEndless() {
        save("endlessData", endlessBests)
    }
    
    func saveTimed() {
        save("timedData", timedBests)
    }
    
    func saveMax() {
        save("maxData", maxBests)
    }
    
    func save(_ filename: String, _ array: [Int]) {
        let urls = manager.urls(for: .documentDirectory, in: .userDomainMask)
        
        if let url = urls.first {
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("json")
            do {
                let data = try JSONSerialization.data(withJSONObject: array, options: [.prettyPrinted])
                try data.write(to: fileURL, options: [])
            } catch {
                fatalError("Couldn't serialize data or write data\n\(error)")
            }
        }
    }
}

func load (_ filename: String) -> [Int]{
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    if let resPath = Bundle.main.resourcePath {
            do {
                let dirContents = try FileManager.default.contentsOfDirectory(atPath: resPath)
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                let filteredFiles = dirContents.filter{ $0.contains("json")}
                for fileName in filteredFiles {
                    if let documentsURL = documentsURL {
                        let sourceURL = Bundle.main.bundleURL.appendingPathComponent(fileName)
                        let destURL = documentsURL.appendingPathComponent(fileName)
                        do { try FileManager.default.copyItem(at: sourceURL, to: destURL) } catch { }
                    }
                }
            } catch {
                print("Files already initialized")
            }
        }
    
    if let url = urls.first {
        var fileURL = url.appendingPathComponent(filename)
        fileURL = fileURL.appendingPathExtension("json")
        do {
            let data = try(Data(contentsOf: fileURL))
            let array = try JSONSerialization.jsonObject(with: data) as? [Int]
            if (array! != []) {
                return array!
            } else {
                if (filename == "endlessData") {
                    return [0, 0, 0, 0, 0]
                } else {
                    return [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                }
            }
        } catch {
            fatalError("Couldn't load data\n\(error)")
        }
    }
    
    return [0]
}

class QuestionGeneration {
    private var operation = 0
    private var numberOne = 0
    private var numberTwo = 0
    private var valid = false
    
    public func easyQuestion() -> equation{
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
            numberTwo = Int.random(in: 1...8)
            valid = false
            while !valid {
                numberOne = Int.random(in: 16...64)
                if (numberOne % numberTwo == 0){
                    valid = true
                }
            }
        }
        let currentRegular = equation.init(operation: operation, numberOne: numberOne, numberTwo: numberTwo)
        return currentRegular
    }
    
    public func mediumQuestion() -> equation{
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
            numberTwo = Int.random(in: 1...12)
            valid = false
            while !valid {
                numberOne = Int.random(in: 72...144)
                if (numberOne % numberTwo == 0){
                    valid = true
                }
            }
        }
        let currentRegular = equation.init(operation: operation, numberOne: numberOne, numberTwo: numberTwo)
        return currentRegular
    }
    
    public func hardQuestion() -> equation{
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
            numberTwo = Int.random(in: 1...25)
            valid = false
            while !valid {
                numberOne = Int.random(in: 250...625)
                if (numberOne % numberTwo == 0){
                    valid = true
                }
            }
        }
        let currentRegular = equation.init(operation: operation, numberOne: numberOne, numberTwo: numberTwo)
        return currentRegular
    }
    
    public func squareQuestion() -> squares{
        operation = Int.random(in: 0...1)
        let number = Int.random(in: 1...25)
        var currentSquare: squares
        if (operation == 0){
            currentSquare = squares.init(operation: operation, numberOne: (number*number))
        } else {
            currentSquare = squares.init(operation: operation, numberOne: number)
        }
        return currentSquare
    }
}
