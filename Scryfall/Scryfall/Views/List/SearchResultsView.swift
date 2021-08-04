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

    @State private var showSettings = false

    @ObservedObject var searchResult: SearchResultsViewModel

    @EnvironmentObject var settings: SettingsViewModel

    // MARK: - DI

    let provider: SymbolProvider

    let cache = ImageCache()

    // MARK: - Init

    init(model: CommonViewModel, client: ScryfallClient) {
        self.searchResult = SearchResultsViewModel(client: client)
        self.provider = DefaultSymbolProvider(
            fileCache: ImageCache(),
            viewModel: model
        )
    }

    // MARK: - Model

    enum Item: Identifiable {
        case card(Card)
        case loader

        var id: String {
            switch self {
            case let .card(card):
                return card.id
            case .loader:
                return "loader"
            }
        }
    }

    var gridItems: [GridItem] = [
        GridItem(.adaptive(minimum: 300))
    ]

    var items: [Item] {
        let cards = searchResult.cards.map { Item.card($0) }
        if searchResult.hasMore {
            return cards + [.loader]
        } else if !cards.isEmpty {
            return cards
        } else {
            return []
        }
    }

    // MARK: - Body

    var body: some View {
        let presentationStyle = settings.presentationStyle

        NavigationView {
            VStack {
                HStack {
                    SearchBar(text: $searchResult.searchText)
                    Button(action: {
                        self.showSettings = true
                    }, label: {
                        Image(systemName: "slider.horizontal.3")
                    })
                }
                .padding(.horizontal)
                .padding(.vertical, Style.listSpacing)

                ScrollView {
                    LazyVGrid(columns: gridItems, alignment: .center, spacing: Style.listSpacing) {
                        ForEach(self.items) { item in
                            VStack {
                                switch item {
                                case let .card(card):
                                    if presentationStyle == .text {
                                        SearchTextView(card: card, provider: provider)
                                    } else {
                                        SearchCardView(card: card, cache: cache)
                                    }
                                case .loader:
                                    HStack {
                                        Spacer()
                                        Spinner(isAnimating: true, style: .medium)
                                        Spacer()
                                    }
                                    .onAppear(perform: {
                                        self.searchResult.onNext.send(())
                                    })
                                }
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
        .sheet(isPresented: $showSettings) {
            SettingsView()
                .environmentObject(settings)
        }
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
