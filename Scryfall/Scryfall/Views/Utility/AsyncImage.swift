//
//  AsyncCardImage.swift
//  Scryfall
//
//  Created by Alexander on 26.07.2021.
//

import Foundation
import SwiftUI
import Combine

class AsyncImage: ObservableObject {
    let fileCache: FileCache
    let uri: URL?
    var subscription: AnyCancellable?

    @Published var image: UIImage?

    init(fileCache: FileCache, uri: URL?) {
        self.fileCache = fileCache
        self.uri = uri

        if let uri = uri {
            self.subscription = fileCache.localUrl(for: uri)
                .subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { _ in
                        // TODO: Don't ignore errors.
                    },
                    receiveValue: { value in
                        self.image = UIImage(contentsOfFile: value.path)
                    }
                )
        }
    }
}
