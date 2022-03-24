//
//  AnswerView.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/14/22.
//

import SwiftUI

struct AnswerViewEndless: View {
    @EnvironmentObject var brain: EndlessBrain
    
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
            
            Text("Average Response Time: \(brain.responseTime) Seconds")
        }
    }
    func useHint() {
        brain.Hint()
    }
    func submit() {
        brain.Submit()
    }
}

struct AnswerView_Previews: PreviewProvider {
    static var previews: some View {
        let brain: EndlessBrain = EndlessBrain()
        AnswerViewEndless()
            .environmentObject(brain)
    }
}
