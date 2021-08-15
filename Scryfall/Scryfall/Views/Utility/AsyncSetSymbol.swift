//
//  AsyncSetSymbolProvider.swift
//  Scryfall
//
//  Created by Alexander on 15.08.2021.
//

import Foundation
import Combine
import SwiftUI

class AsyncSetSymbol: ObservableObject {
    
    let provider: SetProvider

    var subscriptions = Set<AnyCancellable>()

    @Published var image: UIImage?

    init(provider: SetProvider, set: String) {
        self.provider = provider

        provider.image(forSet: set)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] image in
                self?.image = image.withTintColor(.black, renderingMode: .alwaysTemplate)
            })
            .store(in: &subscriptions)
    }
}
