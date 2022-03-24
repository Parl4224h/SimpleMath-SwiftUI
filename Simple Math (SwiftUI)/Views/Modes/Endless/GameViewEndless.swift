//
//  GameViewEndless.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/14/22.
//

import SwiftUI

struct GameViewEndless: View {
    @EnvironmentObject var brain: EndlessBrain
    
    var body: some View {
        VStack {
            StatsViewEndless()
                .padding(.bottom,25)
                .padding(.top, 0)
            
            AnswerViewEndless()
            
            Spacer()
            
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let brain: EndlessBrain = EndlessBrain()
        GameViewEndless()
            .environmentObject(brain)
    }
}
