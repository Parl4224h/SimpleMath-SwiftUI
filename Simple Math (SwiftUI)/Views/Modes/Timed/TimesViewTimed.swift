//
//  TimesViewTimed.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/24/22.
//

import SwiftUI

struct TimesViewTimed: View {
    @EnvironmentObject var brain: TimedBrain
    
    var body: some View {
        NavigationView{
            List{
                NavigationLink {
                    GameViewTimed()
                        .onAppear(perform: {brain.setTimer(20)})
                } label: {
                    Text("10 Seconds")
                }
                NavigationLink {
                    GameViewTimed()
                        .onAppear(perform: {brain.setTimer(20)})
                } label: {
                    Text("20 Seconds")
                }
                NavigationLink {
                    GameViewTimed()
                        .onAppear(perform: {brain.setTimer(20)})
                } label: {
                    Text("30 Seconds")
                }
                NavigationLink {
                    GameViewTimed()
                        .onAppear(perform: {brain.setTimer(20)})
                } label: {
                    Text("40 Seconds")
                }
                NavigationLink {
                    GameViewTimed()
                        .onAppear(perform: {brain.setTimer(20)})
                } label: {
                    Text("50 Seconds")
                }
                NavigationLink {
                    GameViewTimed()
                        .onAppear(perform: {brain.setTimer(20)})
                } label: {
                    Text("60 Seconds")
                }
            }
            .navigationTitle("Time")
        }
    }
}

struct TimesViewTimed_Previews: PreviewProvider {
    static var previews: some View {
        let brain: TimedBrain = TimedBrain()
        TimesViewTimed()
            .environmentObject(brain)
    }
}
