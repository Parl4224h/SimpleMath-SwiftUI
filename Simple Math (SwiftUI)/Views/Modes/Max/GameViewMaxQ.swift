//
//  GameViewMaxQ.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/28/22.
//

import SwiftUI

struct GameViewMaxQ: View {
    @EnvironmentObject var brain: MaxBrain
    
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

struct GameViewMaxQ_Previews: PreviewProvider {
    static var previews: some View {
        let brain = MaxBrain()
        GameViewMaxQ()
            .environmentObject(brain)
    }
}
