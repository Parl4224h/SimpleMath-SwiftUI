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
                StatsViewMaxQ()
                    .padding(.bottom,25)
                    .padding(.top, 0)
                
                AnswerViewMaxQ()
                
                Spacer()
                
            }
            if ($brain.endVisible.wrappedValue) {
                GameOverMaxQ()
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
