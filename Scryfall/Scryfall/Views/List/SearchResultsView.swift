//
//  SearchResultsView.swift
//  Scryfall
//
//  Created by Alexander on 02.07.2021.
//

import SwiftUI
import ScryfallModel

struct SearchResultsView: View {

    @State private var searchText = ""

    @ObservedObject var searchResult: SearchResultsViewModel

    let provider: SymbolProvider

    let cache = ImageCache()

    init(model: CommonViewModel, client: ScryfallClient) {
        self.searchResult = SearchResultsViewModel(client: client)
        self.provider = DefaultSymbolProvider(
            fileCache: ImageCache(),
            viewModel: model
        )
    }

    var gridItems: [GridItem] = [
        GridItem(.adaptive(minimum: 300))
    ]

    var cards: [Card] {
        if case let .success(cards) = searchResult.cards {
            return cards
        } else {
            return []
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    SearchBar(text: $searchResult.searchText)
                    Button(action: {}, label: {
                        Image(systemName: "slider.horizontal.3")
                    })
                }
                .padding(.horizontal)
                .padding(.vertical, Style.listSpacing)

                ScrollView {
                    LazyVGrid(columns: gridItems, alignment: .center, spacing: Style.listSpacing) {
                        ForEach(self.cards) { item in
                            VStack {
                                SearchTextView(card: item, provider: provider)
                                //SearchCardView(card: item, cache: cache)
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
        SearchResultsView(
            model: CommonViewModel(client: StubClient()), client: StubClient()
        )
        .previewDevice("iPhone 8")
    }
}
