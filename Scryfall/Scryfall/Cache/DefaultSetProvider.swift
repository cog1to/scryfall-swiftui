//
//  DefaultSetProvider.swift
//  Scryfall
//
//  Created by Alexander on 13.08.2021.
//

import Foundation
import SwiftUI
import SVGKit
import SVGKitSwift
import Combine
import ScryfallModel

final class DefaultSetProvider: SetProvider {

    // MARK: - Private

    var cache: [String: SVGKImage] = [:]

    let fileCache: ImageCache

    let sets: AnyPublisher<ObjectList<CardSet>, Never>

    // MARK: - Init

    init(fileCache: ImageCache, viewModel: CommonViewModel) {
        self.fileCache = fileCache
        self.sets = viewModel.$sets.eraseToAnyPublisher()
    }

    // MARK: - Public

    func image(forSet set: String) -> AnyPublisher<UIImage, Never> {
        if let image = cache[set] {
            return Just(image.uiImage).eraseToAnyPublisher()
        } else {
            return sets
                .compactMap { list in
                    list.data.first(where: { $0.code == set })?.iconSvgUri
                }
                .flatMap { url in
                    self.fileCache
                        .localUrl(for: url)
                        .catch { _ in Empty<URL, Never>() }
                }
                .map { localUrl in
                    let image = SVGKImage(contentsOf: localUrl)!
                    // Resize to some reasonable value.
                    // 30px@3 seems good for now.
                    image.scaleToFit(inside: CGSize(width: 90, height: 90))
                    return image
                }
                .handleEvents(receiveOutput: { image in
                    self.cache[set] = image
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

