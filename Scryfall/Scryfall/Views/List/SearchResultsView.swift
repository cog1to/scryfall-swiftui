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

    let provider = SymbolProviderImpl(
        fileCache: FileCache(),
        client: StubClient()
    )

    @State private var searchText = ""

    var gridItems: [GridItem] = [
        GridItem(.adaptive(minimum: 280))
    ]

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)

                ScrollView {
                    LazyVGrid(columns: gridItems, alignment: .center, spacing: 10) {
                        ForEach(items.data) { item in
                            VStack {
                                SearchTextView(card: item, provider: provider)
                            }
                        }
                    }
                }
                .padding(.horizontal, 10)
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
