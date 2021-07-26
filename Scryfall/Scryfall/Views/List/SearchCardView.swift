//
//  SearchCard.swift
//  Scryfall
//
//  Created by Alexander on 02.07.2021.
//

import SwiftUI
import ScryfallModel

struct SearchCardView: View {
    let card: Card

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.gray)
                Text(card.name)
            }
            // TODO: Corner radius is not 1:1 MTG card. On real cards it's
            // asymmetrical between X and Y directions.
            .cornerRadius(geometry.size.width * 0.045)
        }
    }
}

struct SearchCardView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCardView(card: ModelStubs.akoum)
            .previewLayout(.fixed(width: 5*40, height: 7*40))
    }
}
