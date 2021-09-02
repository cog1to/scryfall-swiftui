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
    let fileCache: ImageCache
    let uri: URL?
    var subscription: AnyCancellable?

    @Published var image: UIImage?

    init(fileCache: ImageCache, uri: URL?) {
        self.fileCache = fileCache
        self.uri = uri

        if let uri = uri {
            // If file exists already, don't go through the Combine,
            // just initialize immediately.
            if let localUrl = fileCache.immediateLocalUrl(for: uri) {
                image = UIImage(contentsOfFile: localUrl.path)
                return
            }

            self.subscription = fileCache.localUrl(for: uri)
                .subscribe(on: DispatchQueue.global())
                .map {
                    return UIImage(contentsOfFile: $0.path)
                }
                /*.map { image in
                    let size = CGSize(width: 200, height: 280)
                    UIGraphicsBeginImageContextWithOptions(size, false, 0.0);
                    image?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                    let newImage = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    return newImage
                }*/
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { _ in
                        // TODO: Don't ignore errors.
                    },
                    receiveValue: { value in
                        self.image = value
                    }
                )
        }
    }
}
