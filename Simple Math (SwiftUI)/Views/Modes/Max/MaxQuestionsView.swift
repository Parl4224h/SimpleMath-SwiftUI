//
//  MaxQuestionsView.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/23/22.
//

import SwiftUI

struct MaxQuestionsView: View {
    @EnvironmentObject var brain: MaxBrain
    let questions = [3, 5, 10, 15, 20, 25]
    
    var body: some View {
        NavigationView{
            List{
                ForEach(questions, id: \.hashValue) { value in
                    NavigationLink {
                        GameViewMaxQ()
                            .onAppear(perform: {self.brain.viewAppear(questionNumber: value)})
                            .onDisappear(perform: {self.brain.viewDisappear()})
                    } label: {
                        Text("\(value) Questions")
                    }
                }
            }
            .navigationTitle("Questions")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Picker("Difficulty",selection: $brain.difficulty){
                        ForEach(Difficulty.allCases) { difficulty in
                            Text(difficulty.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
    }
}

struct Question: Identifiable {
    var id: ObjectIdentifier
    let value: Int
}

struct MaxQuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        let brain = MaxBrain()
        MaxQuestionsView()
            .environmentObject(brain)
    }
}
