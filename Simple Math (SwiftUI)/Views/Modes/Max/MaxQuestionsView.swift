//
//  MaxQuestionsView.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/23/22.
//

import SwiftUI

struct MaxQuestionsView: View {
    @EnvironmentObject var brain: MaxBrain
    let questions = [Questions.three, Questions.five, Questions.ten, Questions.fifteen, Questions.twenty, Questions.twentyFive]
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Speed Modes")
                    .font(.largeTitle)
                ForEach(questions) {question in
                    NavigationLink {
                        GameViewMaxQ()
                            .onAppear(perform: {brain.viewAppear(questionNumber: question.rawValue)})
                            .onDisappear(perform: {brain.viewDisappear()})
                    } label: {
                        HStack{
                            Text("\(question.rawValue) Questions")
                                .foregroundColor(Color("Background"))
                        }
                        .frame(width: 200)
                        .padding()
                        .background(Color("Text"))
                        .cornerRadius(20)
                    }
                }
                Spacer()
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Picker("Difficulty",selection: $brain.difficulty){
                        ForEach(Difficulty.allCases) { difficulty in
                            Text(difficulty.rawValue.capitalized)
                        }
                    }
                    .onAppear(perform: {
                        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("Background"))
                        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color("Text"))], for: .selected)
                        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color("Background"))], for: .normal)
                        UISegmentedControl.appearance().backgroundColor = UIColor(Color("Text"))
                    })
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
