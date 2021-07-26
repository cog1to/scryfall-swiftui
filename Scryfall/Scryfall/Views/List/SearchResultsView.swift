//
//  SearchResultsView.swift
//  Scryfall
//
//  Created by Alexander on 02.07.2021.
//

import SwiftUI
import ScryfallModel

struct SearchResultsView: View {

    let items: ScryfallModel.List<Card>

    let provider = DefaultSymbolProvider(
        fileCache: FileCache(),
        client: StubClient()
    )

    @State private var searchText = ""

    var gridItems: [GridItem] = [
        GridItem(.adaptive(minimum: Style.cardSize.width))
    ]

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    SearchBar(text: $searchText)
                    Button(action: {}, label: {
                        Image(systemName: "slider.horizontal.3")
                    })
                }
                .padding(.horizontal)
                .padding(.vertical, Style.listSpacing)

                ScrollView {
                    LazyVGrid(columns: gridItems, alignment: .center, spacing: Style.listSpacing) {
                        ForEach(items.data) { item in
                            VStack {
                                SearchTextView(card: item, provider: provider)
                            }
                        }
                    }
                    .padding(.bottom)
                }
                .padding(.horizontal, Style.listSpacing)
            }
            .padding(.top)
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView(items: ModelStubs.avacynSearch)
            .previewDevice("iPhone 8")
    }
}
