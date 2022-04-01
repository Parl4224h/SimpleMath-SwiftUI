//
//  StatsView.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/14/22.
//

import SwiftUI

struct StatsViewEndless: View {
    @EnvironmentObject var brain: EndlessBrain
    
    var body: some View {
        
        HStack (alignment: .center){
            CircularRatioBar(large: $brain.streakLarge, small: $brain.streakSmall, primaryColor: Color.accentColor, secondaryColor: Color.gray, delimiter: ":")
                .frame(width: .infinity, height: 75.0)
                .padding()
            
            CircularRatioBar(large: $brain.correctLarge, small: $brain.correctSmall, primaryColor: Color.green, secondaryColor: Color.red, delimiter: ":")
                .frame(width: .infinity, height: 75.0)
                .padding()
            
            CircularPercentageBar(progress: $brain.percentCorrect)
                .frame(width: .infinity, height: 75.0)
                .padding()
            
            Spacer()
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        let brain: EndlessBrain = EndlessBrain()
        StatsViewEndless()
            .environmentObject(brain)
    }
}
