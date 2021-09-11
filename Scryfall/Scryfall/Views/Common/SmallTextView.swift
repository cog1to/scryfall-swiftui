//
//  SmallTextView.swift
//  Scryfall
//
//  Created by Alexander on 11.08.2021.
//

import SwiftUI

struct LinkTextView: View {
    let prefix: String
    let link: String

    var body: some View {
        Text(prefix)
            .font(Style.Fonts.small)
        + Text(link)
            .font(Style.Fonts.small)
            .foregroundColor(Color("Link"))
    }
}

struct LinkTextView_Previews: PreviewProvider {
    static var previews: some View {
        LinkTextView(prefix: "", link: "")
    }
}
