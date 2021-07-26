//
//  ContentView.swift
//  Scryfall
//
//  Created by Alexander on 26.06.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {

    let client = StubClient()

    let cache = FileCache()

    let provider: SymbolProvider

    init() {
        provider = SymbolProviderImpl(
            fileCache: cache,
            client: client
        )
    }

    var body: some View {
        SearchResultsView(items: ModelStubs.avacynSearch)
//        HStack {
//            MagicTextView(text: "Whenever you roll {W}{U}{B}, destroy target creature that isn't enchanted.", provider: provider)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
