//
//  TimedView.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/23/22.
//

import SwiftUI

struct TimedView: View {
    @EnvironmentObject var brain: TimedBrain
    
    let times = [Times.ten, Times.twenty, Times.thirty, Times.forty, Times.fifty, Times.sixty]
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Timed Modes")
                    .font(.largeTitle)
                ForEach(times) {time in
                    NavigationLink {
                        GameViewTimed()
                            .onAppear(perform: {brain.viewAppear(time: time.rawValue)})
                            .onDisappear(perform: {brain.viewDisappear()})
                    } label: {
                        HStack{
                            Text("\(time.rawValue) Seconds")
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

struct TimedView_Previews: PreviewProvider {
    static var previews: some View {
        let brain: TimedBrain = TimedBrain()
        TimedView()
            .environmentObject(brain)
    }
}
