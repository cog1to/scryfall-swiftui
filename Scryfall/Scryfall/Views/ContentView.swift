//
//  ContentView.swift
//  Scryfall
//
//  Created by Alexander on 26.06.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        SearchResultsView(
            client: NetworkClient(),
            provider: UserDefaultsSettingsProvider()
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
