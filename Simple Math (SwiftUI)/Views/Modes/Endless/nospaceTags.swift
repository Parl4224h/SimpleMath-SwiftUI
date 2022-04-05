//
//  nospaceTags.swift
//  Simple Math (SwiftUI)
//
//  Created by Parker Hoffmann on 4/3/22.
//

import SwiftUI

struct nospaceTags: View {
    
    var tags: Array<String>
    
    var body: some View {
        HStack {
            ForEach(tags, id: \.self) { tag in
                Text("\(tag)")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .padding(.vertical, 2)
                    .foregroundColor(.black)
            }
        }
    }
}

struct nospaceTage_Previews: PreviewProvider {
    static var previews: some View {
        nospaceTags()
    }
}
