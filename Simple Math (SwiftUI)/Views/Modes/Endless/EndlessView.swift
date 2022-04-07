//
//  EndlessView.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/14/22.
//

import SwiftUI

struct EndlessView: View {
    @EnvironmentObject var brain: EndlessBrain
    
    let gModes = [Difficulty.easy, Difficulty.medium, Difficulty.hard, Difficulty.squares, Difficulty.extreme]
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Endless Modes")
                    .font(.largeTitle)
                ForEach(gModes) {gMode in
                    NavigationLink {
                        GameViewEndless()
                            .onAppear(perform: {brain.viewAppear()})
                            .onDisappear(perform: {brain.viewDisappear()})
                    } label: {
                        HStack{
                            Text("\(gMode.rawValue.capitalized)")
                                .foregroundColor(Color("\(gMode.rawValue)Text"))
                        }
                        .frame(width: 200)
                        .padding()
                        .background(Color(gMode.rawValue))
                        .cornerRadius(20)
                    }
                }
                Spacer()
            }
            .listStyle(PlainListStyle())
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
