//
//  CircularPercentageBar.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/14/22.
//

import SwiftUI

struct CircularPercentageBar: View {
    @Binding var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .foregroundColor(Color.red)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(lineWidth: 20.0)
                .foregroundColor(Color.green)
                .rotationEffect(Angle(degrees: 270))
            
            
            Text("\(Int(progress*100))%")
                .bold()
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CircularPercentageBar(progress: .constant(Float(0.2)))
    }
}
