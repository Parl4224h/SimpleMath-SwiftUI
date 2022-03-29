//
//  GameOverMaxQ.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/28/22.
//

import SwiftUI

struct GameOverMaxQ: View {
    @EnvironmentObject var brain: MaxBrain
    
    var body: some View {
        VStack (spacing : 10) {
            Text("Game Over")
                .font(.title)
            
            Text("Time: \(brain.timeElapsed) Seconds")
            Text("Average Time: \(Int(Float(brain.timeElapsed) / Float(brain.totalQuestionsLarge))) Seconds")
            Text("Record Time: \(brain.recordTime)")
            Text("Longest Streak: \(brain.currentCorrectSmall)")
            
            Spacer()
            
            Button("Close", action: close)
            }
            .padding()
            .frame(width: 300, height: 250)
            .background(Color("Background"))
            .cornerRadius(20)
            .shadow(radius: 20)
    }
    
    func close(){
        brain.closeEndScreen()
    }
}

struct GameOverMaxQ_Previews: PreviewProvider {
    static var previews: some View {
        let brain = MaxBrain()
        GameOverMaxQ()
            .environmentObject(brain)
    }
}
