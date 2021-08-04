//
//  SettingsViewModel.swift
//  Scryfall
//
//  Created by Alexander on 04.08.2021.
//

import Foundation

class SettingsViewModel: ObservableObject {

    // MARK: - Private

    private let provider: SettingsProvider

    // MARK: - Init

    init(provider: SettingsProvider) {
        self.provider = provider
        presentationStyle = provider.presentationStyle ?? .text
    }

    // MARK: - Observed state

    @Published var presentationStyle: PresentationStyle = .text {
        didSet {
            provider.presentationStyle = presentationStyle
        }
    }
}
