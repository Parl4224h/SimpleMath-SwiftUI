//
//  Simple_Math__SwiftUI_App.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/11/22.
//

import SwiftUI

@main
struct Simple_Math__SwiftUI_App: App {
    @StateObject private var endlessBrain = EndlessBrain()
    @StateObject private var timedBrain = TimedBrain()
    @StateObject private var maxBrain = MaxBrain()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(endlessBrain)
                .environmentObject(timedBrain)
                .environmentObject(maxBrain)
        }
    }
}
