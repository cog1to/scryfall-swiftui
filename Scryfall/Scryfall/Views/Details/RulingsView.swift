//
//  RulingsView.swift
//  Scryfall
//
//  Created by Alexander on 30.08.2021.
//

import SwiftUI
import ScryfallModel

struct RulingsView: View {
    let items: [Ruling]

    var columns: [GridItem] {
        if UITraitCollection.current.horizontalSizeClass == .regular {
            return [GridItem(.flexible()), GridItem(.flexible())]
        } else {
            return [GridItem(.flexible())]
        }
    }

    init(items: [Ruling]) {
        self.items = items
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Notes and rules information".uppercased())
                .font(Style.Fonts.rulingHeavy)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 4, leading: 0, bottom: 10, trailing: 0))

            LazyVGrid(columns: columns, alignment: .leading, spacing: 4) {
                ForEach(items, id: \.id) { item in
                    RulingView(ruling: item)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
    }
}

struct RulingView: View {
    let ruling: Ruling

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(ruling.comment)
                .font(Style.Fonts.ruling)
                .foregroundColor(Color("Black"))
            Text("(\(ruling.publishedAt))")
                .font(Style.Fonts.rulingSubtitle)
                .foregroundColor(Color("Gray"))
            Spacer()
        }
    }
}

struct RulingsView_Previews: PreviewProvider {
    static var previews: some View {
        RulingsView(items: [
            Ruling(
                id: "1",
                source: "wotc", published: "2020-07-08",
                comment: "Because damage remains marked on a creature until the damage is removed as the turn ends, nonlethal damage dealt to a creature you control may become lethal if Avacyn leaves the battlefield during that turn."
            ),
            Ruling(
                id: "2",
                source: "wotc", published: "2020-07-20",
                comment: "A planeswalker with indestructible still loses loyalty as it’s dealt damage. It is put into its owner’s graveyard if its loyalty becomes 0."
            )
        ])
        .previewDevice("iPod touch (7th generation)")
    }
}
