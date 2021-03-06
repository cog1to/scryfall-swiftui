//
//  ScryfallApp.swift
//  Scryfall
//
//  Created by Alexander on 26.06.2021.
//

import SwiftUI

@main
struct ScryfallApp: App {

    // MARK: - Environment

    var commonViewModel = CommonViewModel(client: NetworkClient())

    var settingsModel = SettingsViewModel(provider: UserDefaultsSettingsProvider())

    // MARK: - Content

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(commonViewModel)
                .environmentObject(settingsModel)
        }
    }
}
