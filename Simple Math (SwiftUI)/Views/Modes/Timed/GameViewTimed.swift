//
//  GameViewTimed.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/24/22.
//

import SwiftUI

struct GameViewTimed: View {
    @EnvironmentObject var brain: TimedBrain
    
    var body: some View {
        ZStack{
            VStack {
                StatsViewTimed()
                    .padding(.bottom,25)
                    .padding(.top, 0)
                
                AnswerViewTimed()
                
                Spacer()
                
            }
            if ($brain.endVisible.wrappedValue) {
                GameOverTimed()
            }
        }
    }
}

struct GameViewTimed_Previews: PreviewProvider {
    static var previews: some View {
        let brain: TimedBrain = TimedBrain()
        GameViewTimed()
            .environmentObject(brain)
    }
}
