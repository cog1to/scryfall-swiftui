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

    let items: ObjectList<Card>

    let provider: SymbolProvider

    let cache = ImageCache()

    init(items: ObjectList<Card>, model: CommonViewModel) {
        self.items = items
        self.provider = DefaultSymbolProvider(
            fileCache: ImageCache(),
            viewModel: model
        )
    }

    var gridItems: [GridItem] = [
        GridItem(.adaptive(minimum: 300))
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
            items: ModelStubs.avacynSearch,
            model: CommonViewModel(client: StubClient())
        )
        .previewDevice("iPhone 8")
    }
}
