//
//  NoSpaceList.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 4/3/22.
//

import SwiftUI

struct NoSpaceList: View {
    let data = [Difficulty.easy, Difficulty.medium, Difficulty.hard, Difficulty.squares, Difficulty.extreme]
    
    var body: some View {
        GeometryReader{ geometry in
            NavigationView {
                VStack{
                    ForEach(data) {gMode in
                        NavigationLink {
                            GameViewEndless()
                        } label: {
                            HStack{
                                
                                Text("\(gMode.rawValue.capitalized)")
                                    .foregroundColor(Color("Text"))
                            }
                            .frame(width: 200)
                            .padding()
                            .background(Color(gMode.rawValue))
                            .cornerRadius(20)
                        }
                    }
                }
            }
        }
    }
    func display() {
        print("test")
    }
    
}

struct NoSpaceList_Previews: PreviewProvider {
    static var previews: some View {
        NoSpaceList()
    }
}
