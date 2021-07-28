//
//  ContentView.swift
//  Scryfall
//
//  Created by Alexander on 26.06.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var model: CommonViewModel

    var body: some View {
        SearchResultsView(model: model, client: DefaultClient())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
