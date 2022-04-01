//
//  ContentView.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/11/22.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .endless
    
    enum Tab {
        case endless
        case max
        case timed
    }
    
    var body: some View {
        TabView(selection: $selection) {
            EndlessView()
                .tabItem {
                    Label("Endless Mode", systemImage: "infinity")
                }
            TimedView()
                .tabItem {
                    Label("Timed Mode", systemImage: "timer")
                }
            MaxQuestionsView()
                .tabItem {
                    Label("Speed Mode", systemImage: "stopwatch")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MaxBrain())
            .environmentObject(TimedBrain())
            .environmentObject(EndlessBrain())
    }
}
