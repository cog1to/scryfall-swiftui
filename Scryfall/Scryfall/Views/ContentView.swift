//
//  ContentView.swift
//  Scryfall
//
//  Created by Alexander on 26.06.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {

    init() {
        UINavigationBar.appearance().backgroundColor = UIColor(named: "Background")
        UINavigationBar.appearance().tintColor = UIColor(named: "Accent")
    }

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

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()

        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = UIColor(named: "Background")

        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.backgroundColor = UIColor(named: "Background")

        navigationBar.standardAppearance = standardAppearance
        //navigationBar.compactAppearance = compactAppearance
        navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
    }
}
