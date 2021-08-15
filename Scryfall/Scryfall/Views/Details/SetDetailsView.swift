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

    @State var height: CGFloat = .zero

    var body: some View {
        HStack(alignment: .top, spacing: 6) {
            SetImage(set: setCode, provider: provider)
                .frame(height: max(0, self.height - 8), alignment: .center)
                .padding(.vertical, 4)
            VStack(alignment: .leading, spacing: 2) {
                Text("\(setName) (\(setCode.uppercased()))")
                    .font(Style.Fonts.subtitle)
                Text("#\(cardNumber) · \(rarity.title) · \(language.title)")
                    .font(Style.Fonts.small)
            }
            .foregroundColor(Color("BrightText"))
            .alignmentGuide(.top, computeValue: { d in
                DispatchQueue.main.async {
                    self.height = d.height
                }
                return d[.top]
            })
            Spacer()
        }
        .padding(8)
        .background(Color("Accent"))
        .cornerRadius(2)
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
