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
            
            Text("Total Questions Answered: \(brain.correctLarge)")
            Text("Correct Questions: \(brain.correctSmall)")
            Text("Longest Streak: \(brain.currentCorrectSmall)")
            Text("Record Streak: \(brain.currentCorrecLarge)")
            
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
