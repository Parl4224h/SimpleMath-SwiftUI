//
//  GameOverTimed.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/24/22.
//

import SwiftUI
// TODO: Make a game over screen
struct GameOverTimed: View {
    var body: some View {
        VStack (spacing : 10) {
               Text("Choices Of Fruits").font(Font.custom("Avenir-Black", size: 18.0))
               Button(action: {
                   withAnimation {
                    }
                }, label: {
                    Text("Close")
                })
            
            }
            .padding()
            .frame(width: 300, height: 500)
            .background(Color("Background"))
            .cornerRadius(20)
            .shadow(radius: 20)
    }
}

struct GameOverTimed_Previews: PreviewProvider {
    static var previews: some View {
        GameOverTimed()
    }
}
