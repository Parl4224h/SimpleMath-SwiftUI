//
//  DifficultyPickerTimed.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/24/22.
//

import SwiftUI

struct DifficultyPickerTimed: View {
    @EnvironmentObject var brain: TimedBrain
    
    var body: some View {
        Picker("Difficulty",selection: $brain.difficulty){
            ForEach(Difficulty.allCases) { difficulty in
                Text(difficulty.rawValue.capitalized)
            }
        }
        .pickerStyle(.segmented)
    }
}

struct DifficultyPickerTimed_Previews: PreviewProvider {
    static var previews: some View {
        let brain: TimedBrain = TimedBrain()
        DifficultyPickerTimed()
            .environmentObject(brain)
    }
}
