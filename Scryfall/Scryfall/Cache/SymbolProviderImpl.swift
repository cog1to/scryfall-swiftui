//
//  SymbolProviderImpl.swift
//  Scryfall
//
//  Created by Alexander on 18.07.2021.
//

import Foundation
import SwiftUI
import SVGKit
import SVGKitSwift
import Combine
import ScryfallModel

final class SymbolProviderImpl: SymbolProvider {

    // MARK: - Private

    var cache: [String: SVGKImage] = [:]

    let fileCache: FileCache

    let symbology: AnyPublisher<ScryfallModel.List<CardSymbol>, Error>

    // MARK: - Init

    init(fileCache: FileCache, client: ScryfallClient) {
        self.fileCache = fileCache
        self.symbology = client.symbology().shareReplay(capacity: 1).eraseToAnyPublisher()
    }

    // MARK: - Public

    func image(forSymbol symbol: String) -> AnyPublisher<UIImage, Never> {
        if let image = cache[symbol] {
            return Just(image.uiImage).eraseToAnyPublisher()
        } else {
            return symbology
                .compactMap { list in
                    list.data.first(where: { $0.symbol == symbol })?.svgUri
                }
                .flatMap { url in
                    self.fileCache
                        .localUrl(for: url)
                        .catch { _ in Empty<URL, Never>() }
                }
                .map { localUrl in
                    let image = SVGKImage(contentsOf: localUrl)!
                    image.scaleToFit(inside: CGSize(width: 16, height: 16))
                    return image
                }
                .handleEvents(receiveOutput: { image in
                    self.cache[symbol] = image
                })
                .map { image in
                    image.uiImage
                }
                .catch {
                    _ in Empty<UIImage, Never>()
                }
                .eraseToAnyPublisher()
        }
    }
}
