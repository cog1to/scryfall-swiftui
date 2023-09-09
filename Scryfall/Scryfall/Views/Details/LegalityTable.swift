//
//  LegalityTable.swift
//  Scryfall
//
//  Created by Alexander on 13.08.2021.
//

import SwiftUI
import ScryfallModel

struct LegalityTable: View {

    let legalities: LegalityList

    var columns: [GridItem] = [
        GridItem(.flexible(maximum: 100)),
        GridItem(.flexible(minimum: 40), spacing: 2, alignment: .leading),
        GridItem(.flexible(maximum: 100)),
        GridItem(.flexible(minimum: 40), spacing: 2, alignment: .leading)
    ]

    var body: some View {
        LazyVGrid(
            columns: columns,
            alignment: .center,
            spacing: 4
        ) {
            ForEach(cells, id: \.id) { cell in
                switch cell {
                case let .value(_, legality):
                    Text(legality.title)
                        .font(Style.Fonts.smallFixed)
                        .foregroundColor(Color("BrightText"))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 4)
                        .background(legality.color)
                        .cornerRadius(2)
                case let .name(name):
                    Text(name).font(Style.Fonts.small)
                }
            }
        }
    }

    enum Cell: Identifiable {
        case value(String, LegalityList.Legality)
        case name(String)

        var id: String {
            switch self {
            case let .value(name, _):
                return "\(name)_value"
            case let .name(name):
                return name
            }
        }
    }

    var cells: [Cell] {
        [
            .value("Standard", legalities.standard), .name("Standard"),
            .value("Brawl", legalities.brawl), .name("Brawl"),
            .value("Pioneer", legalities.pioneer), .name("Pioneer"),
            .value("Historic", legalities.historic), .name("Historic"),
            .value("Modern", legalities.modern), .name("Modern"),
            .value("Pauper", legalities.pauper), .name("Pauper"),
            .value("Legacy", legalities.legacy), .name("Legacy"),
            .value("Penny", legalities.penny), .name("Penny"),
            .value("Vintage", legalities.vintage), .name("Vintage"),
            .value("Commander", legalities.commander), .name("Commander"),
            .value("Alchemy", legalities.alchemy), .name("Alchemy"),
            .value("Explorer", legalities.explorer), .name("Explorer"),
            .value("Oathbreaker", legalities.oathbreaker), .name("Oathbreaker"),
        ]
    }
}

struct LegalityTable_Previews: PreviewProvider {
    static var previews: some View {
        LegalityTable(legalities: ModelStubs.abominationOfGudul.legalities!)
    }
}
