//
//  CircularRatioBar.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 3/14/22.
//

import SwiftUI

struct CircularRatioBar: View {
    @Binding var large: Int
    @Binding var small: Int
    var primaryColor: Color
    var secondaryColor: Color
    var delimiter: String
    
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .foregroundColor(secondaryColor)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(Float(small)/Float(large), 1.0)))
                .stroke(lineWidth: 20.0)
                .foregroundColor(primaryColor)
                .rotationEffect(Angle(degrees: 270))
            
            Text("\(small)\(delimiter)\(large)")
                .bold()
        }
    }
}

struct CircularRatioBar_Previews: PreviewProvider {
    static var previews: some View {
        CircularRatioBar(large: .constant(12), small: .constant(6), primaryColor: Color.green, secondaryColor: Color.red, delimiter: ":")
    }
}
