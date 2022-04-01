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
