//
//  AsyncSymbolSet.swift
//  Scryfall
//
//  Created by Alexander on 25.07.2021.
//

import Foundation
import Combine
import SwiftUI

class AsyncSymbolSet: ObservableObject {

    let provider: SymbolProvider

    var subscriptions = Set<AnyCancellable>()

    @Published var symbols: [String: UIImage]

    init(provider: SymbolProvider, symbols: Set<String>) {
        self.symbols = [:]
        self.provider = provider

        for symbol in symbols {
            provider.image(forSymbol: symbol)
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { [weak self] image in
                    self?.symbols[symbol] = image
                })
                .store(in: &subscriptions)
        }
    }
}
