//
//  TimedView.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/23/22.
//

import SwiftUI

struct TimedView: View {
    var body: some View {
        DifficultyPickerTimed()
        TimesViewTimed()
    }
}

struct TimedView_Previews: PreviewProvider {
    static var previews: some View {
        let brain: TimedBrain = TimedBrain()
        TimedView()
            .environmentObject(brain)
    }
}
