//
//  CommonViewModel.swift
//  Scryfall
//
//  Created by Alexander on 28.07.2021.
//

import Foundation
import Combine
import ScryfallModel
import SwiftUI

class CommonViewModel: ObservableObject {

    // MARK: - Observed state

    @Published var symbology: ObjectList<CardSymbol> = .empty()

    @Published var abilityWords: Catalog<String> = .empty()

    // MARK: - Internal state

    let queue = DispatchQueue(label: "ru.aint.Scryfall.CommonViewModel", attributes: .concurrent)

    init(client: ScryfallClient) {
        client.symbology()
            .replaceError(with: .empty())
            .receive(on: DispatchQueue.main)
            .assign(to: &$symbology)

        client.abilityWords()
            .replaceError(with: .empty())
            .print()
            .receive(on: DispatchQueue.main)
            .assign(to: &$abilityWords)
    }
}
