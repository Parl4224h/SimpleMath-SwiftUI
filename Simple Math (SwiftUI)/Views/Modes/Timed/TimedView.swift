//
//  TimedView.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/23/22.
//

import SwiftUI

struct TimedView: View {
    @EnvironmentObject var brain: TimedBrain
    
    var body: some View {
        NavigationView{
            List{
                NavigationLink {
                    GameViewTimed()
                        .onAppear(perform: {brain.viewAppear(time: 10)})
                        .onDisappear(perform: {brain.viewDisappear()})
                } label: {
                    Text("10 Seconds")
                }
                NavigationLink {
                    GameViewTimed()
                        .onAppear(perform: {brain.viewAppear(time: 20)})
                        .onDisappear(perform: {brain.viewDisappear()})
                } label: {
                    Text("20 Seconds")
                }
                NavigationLink {
                    GameViewTimed()
                        .onAppear(perform: {brain.viewAppear(time: 30)})
                        .onDisappear(perform: {brain.viewDisappear()})
                } label: {
                    Text("30 Seconds")
                }
                NavigationLink {
                    GameViewTimed()
                        .onAppear(perform: {brain.viewAppear(time: 40)})
                        .onDisappear(perform: {brain.viewDisappear()})
                } label: {
                    Text("40 Seconds")
                }
                NavigationLink {
                    GameViewTimed()
                        .onAppear(perform: {brain.viewAppear(time: 50)})
                        .onDisappear(perform: {brain.viewDisappear()})
                } label: {
                    Text("50 Seconds")
                }
                NavigationLink {
                    GameViewTimed()
                        .onAppear(perform: {brain.viewAppear(time: 60)})
                        .onDisappear(perform: {brain.viewDisappear()})
                } label: {
                    Text("60 Seconds")
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
