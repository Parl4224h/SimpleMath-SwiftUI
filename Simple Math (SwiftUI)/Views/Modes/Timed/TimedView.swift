//
//  TimedView.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/23/22.
//

import SwiftUI

struct TimedView: View {
    @EnvironmentObject var brain: TimedBrain
    
    let times = [10, 20, 30, 40, 50, 60]
    
    var body: some View {
        NavigationView{
            List{
                ForEach(times, id: \.hashValue) { value in
                    NavigationLink {
                        GameViewTimed()
                            .onAppear(perform: {brain.viewAppear(time: value)})
                            .onDisappear(perform: {brain.viewDisappear()})
                    } label: {
                        Text("\(value) Seconds")
                    }
                }
            }
            .navigationTitle("Time")
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

struct TimedView_Previews: PreviewProvider {
    static var previews: some View {
        let brain: TimedBrain = TimedBrain()
        TimedView()
            .environmentObject(brain)
    }
}
