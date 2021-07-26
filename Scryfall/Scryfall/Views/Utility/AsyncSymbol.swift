//
//  AsyncSymbol.swift
//  Scryfall
//
//  Created by Alexander on 22.07.2021.
//

import Foundation
import Combine
import SwiftUI

class AsyncSymbol: ObservableObject {

    let provider: SymbolProvider

    var subscription: AnyCancellable?

    let text: String

    @Published var image: UIImage?

    init(provider: SymbolProvider, symbol: String) {
        self.text = symbol
        self.provider = provider
        
        subscription = provider.image(forSymbol: symbol)
            .subscribe(on: DispatchQueue.main)
            .sink(receiveValue: { img in
                self.image = img
            })
    }
}
