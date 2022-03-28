//
//  AnswerViewTimed.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/24/22.
//

import SwiftUI

struct AnswerViewTimed: View {
    @EnvironmentObject var brain: TimedBrain
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("\(brain.questionText)")
            
            HStack(alignment: .center, spacing: 5) {
                Button("Hint", action: useHint)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                
                TextField("answer", text: $brain.answerText)
                    .foregroundColor(brain.answerTextColor)
                    .padding()
                    .background(brain.answerColor)
                    .cornerRadius(10)
                    .keyboardType(.numberPad)
                
                Button("Submit", action: submit)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
            
            Text("Time Remaining: \(brain.timeRemaining < 0 ? 0 : brain.timeRemaining) Seconds")
                .onReceive(timer) {_ in
                    if (brain.timeRemaining > 0){
                        brain.timeRemaining -= 1
                    } else if (brain.timeRemaining == 0){
                        brain.timeRemaining -= 1
                        if (brain.isVisible) {
                            print("\(brain.timeRemaining)")
                            brain.gameOver()
                        }
                    }
                }
        }
    }
    
    func useHint() {
        brain.Hint()
    }
    func submit() {
        brain.Submit()
    }
}

struct AnswerViewTimed_Previews: PreviewProvider {
    static var previews: some View {
        let brain: TimedBrain = TimedBrain()
        AnswerViewTimed()
            .environmentObject(brain)
    }
}
