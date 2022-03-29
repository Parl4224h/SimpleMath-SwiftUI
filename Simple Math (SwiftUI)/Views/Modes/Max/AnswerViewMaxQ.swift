//
//  AnswerViewMaxQ.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/28/22.
//

import SwiftUI

struct AnswerViewMaxQ: View {
    @EnvironmentObject var brain: MaxBrain
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
            
            Text("Time Elapsed: \(brain.timeElapsed) Seconds")
                .onReceive(timer) {_ in
                    if (!brain.isOver){
                        brain.timeElapsed += 1
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

struct AnswerViewMaxQ_Previews: PreviewProvider {
    static var previews: some View {
        let brain = MaxBrain()
        AnswerViewMaxQ()
            .environmentObject(brain)
    }
}
