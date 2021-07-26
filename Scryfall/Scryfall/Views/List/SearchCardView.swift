//
//  SearchCard.swift
//  Scryfall
//
//  Created by Alexander on 02.07.2021.
//

import SwiftUI
import ScryfallModel

struct SearchCardView: View {

    // MARK: - Model

    let card: Card
    @ObservedObject var image: AsyncImage

    init(card: Card, cache: FileCache) {
        self.card = card
        if let imageUris = card.imageUris {
            self.image = AsyncImage(fileCache: cache, uri: imageUris.png)
        } else {
            let faceImageUris = card.cardFaces?.first?.imageUris
            self.image = AsyncImage(fileCache: cache, uri: faceImageUris?.png)
        }
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            Image(uiImage: image.image ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: Style.cardSize.width, minHeight: Style.cardSize.height)
            image.image == nil
                ? Text(card.name)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                : nil
        }
    }
}

struct SearchCardView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCardView(card: ModelStubs.akoum, cache: FileCache())
            .previewLayout(.fixed(width: Style.cardSize.width, height: Style.cardSize.height))
    }
}
