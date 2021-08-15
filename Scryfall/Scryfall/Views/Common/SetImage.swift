//
//  SetImage.swift
//  Scryfall
//
//  Created by Alexander on 15.08.2021.
//

import SwiftUI

struct SetImage: View {

    let set: String

    @ObservedObject var symbol: AsyncSetSymbol

    init(set: String, provider: SetProvider) {
        self.set = set
        self.symbol = AsyncSetSymbol(
            provider: provider,
            set: set
        )
    }

    var body: some View {
        Image(uiImage: symbol.image ?? UIImage())
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(Color("BrightText"))
    }
}
