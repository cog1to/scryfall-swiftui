//
//  SectionDivider.swift
//  Scryfall
//
//  Created by Alexander on 12.08.2021.
//

import SwiftUI

struct SectionDivider: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color("SectionSeparator").frame(height: 4)
            Color("SectionSeparatorShadow").frame(height: 1)
                .blur(radius: 1.0)
                .offset(y: -1.0)
                .opacity(0.7)
        }
        .clipped()
        .frame(height: 8)
    }
}

struct SectionDivider_Previews: PreviewProvider {
    static var previews: some View {
        SectionDivider()
    }
}
