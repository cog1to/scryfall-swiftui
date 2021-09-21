//
//  SetDetailsView.swift
//  Scryfall
//
//  Created by Alexander on 13.08.2021.
//

import SwiftUI
import ScryfallModel

struct SetDetailsView: View {
    let setName: String
    let setCode: String
    let cardNumber: String
    let rarity: Rarity
    let language: Language
    let provider: SetProvider

    var body: some View {
        HStack(alignment: .top, spacing: 6) {
            SetImage(set: setCode, provider: provider)
                .frame(
                    height: UIFontMetrics(forTextStyle: .body).scaledValue(for: 32),
                    alignment: .center
                )
                .padding(.vertical, 4)
            VStack(alignment: .leading, spacing: 2) {
                Text("\(setName) (\(setCode.uppercased()))")
                    .font(Style.Fonts.subtitle)
                Text("#\(cardNumber) · \(rarity.title) · \(language.title)")
                    .font(Style.Fonts.small)
            }
            .foregroundColor(Color("BrightText"))

            Spacer()
        }
        .padding(8)
    }
}

struct SetDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SetDetailsView(
            setName: "Shadows over Innistrad",
            setCode: "soi",
            cardNumber: "5",
            rarity: .mythic,
            language: .english,
            provider: DefaultSetProvider(
                fileCache: ImageCache(),
                viewModel: CommonViewModel(client: StubClient())
            )
        )
    }
}
