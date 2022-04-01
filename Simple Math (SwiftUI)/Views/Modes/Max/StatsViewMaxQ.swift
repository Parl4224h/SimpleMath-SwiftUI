//
//  StatsViewMaxQ.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/28/22.
//

import SwiftUI

struct StatsViewMaxQ: View {
    @EnvironmentObject var brain: MaxBrain
    
    var body: some View {
        
        HStack (alignment: .center){
            // Streak
            CircularRatioBar(large: $brain.streakLarge, small: $brain.streakSmall, primaryColor: Color.accentColor, secondaryColor: Color.gray, delimiter: ":")
                .frame(width: .infinity, height: 75.0)
                .padding()
            //Correct : Total
            CircularRatioBar(large: $brain.totalQuestionsLarge, small: $brain.totalQuestionsSmall, primaryColor: Color.green, secondaryColor: Color.red, delimiter: ":")
                .frame(width: .infinity, height: 75.0)
                .padding()
            //Percent Correct
            CircularPercentageBar(progress: $brain.percentCorrect)
                .frame(width: .infinity, height: 75.0)
                .padding()
            
            Spacer()
        }
    }
}

struct StatsViewMaxQ_Previews: PreviewProvider {
    static var previews: some View {
        StatsViewMaxQ()
    }
}
