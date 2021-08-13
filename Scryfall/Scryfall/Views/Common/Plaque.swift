//
//  PlaqueView.swift
//  Scryfall
//
//  Created by Alexander on 12.08.2021.
//

import SwiftUI

struct Plaque: View {
    let text: String
    let bright: Bool

    var body: some View {
        HStack(alignment: .center) {
            Text(text)
                .foregroundColor(Color("BrightText"))
                .font(Style.Fonts.small)
        }
        .background(Color(bright ? "PlaqueGreen" : "PlaqueGray"))
        .cornerRadius(4)
    }
}

struct Plaque_Previews: PreviewProvider {
    static var previews: some View {
        Plaque(text: "LEGAL", bright: true)
    }
}
