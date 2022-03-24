//
//  EndlessView.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/14/22.
//

import SwiftUI

struct EndlessView: View {
    @EnvironmentObject var brain: EndlessBrain
    
    var body: some View {
        NavigationView {
            List{
                NavigationLink {
                    GameViewEndless()
                        .onAppear(perform: {brain.setDifficulty(0)})
                } label: {
                    Text("Easy")
                }
                NavigationLink {
                    GameViewEndless()
                        .onAppear(perform: {brain.setDifficulty(1)})
                } label: {
                    Text("Medium")
                }
                NavigationLink {
                    GameViewEndless()
                        .onAppear(perform: {brain.setDifficulty(2)})
                } label: {
                    Text("Hard")
                }
                NavigationLink {
                    GameViewEndless()
                        .onAppear(perform: {brain.setDifficulty(3)})
                } label: {
                    Text("Squares")
                }
                NavigationLink {
                    GameViewEndless()
                        .onAppear(perform: {brain.setDifficulty(4)})
                } label: {
                    Text("Extreme")
                }
            }
            .navigationTitle("Endless Modes")
        }
    }
}

struct EndlessView_Previews: PreviewProvider {
    static var previews: some View {
        let brain: EndlessBrain = EndlessBrain()
        EndlessView()
            .environmentObject(brain)
.previewInterfaceOrientation(.portrait)
    }
}
