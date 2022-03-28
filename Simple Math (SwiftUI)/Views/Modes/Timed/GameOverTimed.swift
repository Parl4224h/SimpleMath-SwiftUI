//
//  GameOverTimed.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/24/22.
//

import SwiftUI
// TODO: Make a game over screen
struct GameOverTimed: View {
    @EnvironmentObject var brain: TimedBrain
    
    var body: some View {
        VStack (spacing : 10) {
            Text("Game Over")
                .font(.title)
            
            Text("Total Questions Answered: \(brain.correctLarge)")
            Text("Correct Questions: \(brain.correctSmall)")
            Text("Longest Streak: \(brain.streakSmall)")
            Text("Record Streak: \(brain.streakLarge)")
            
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

struct GameOverTimed_Previews: PreviewProvider {
    static var previews: some View {
        let brain: TimedBrain = TimedBrain()
        GameOverTimed()
            .environmentObject(brain)
    }
}
