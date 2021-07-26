//
//  ImageCache.swift
//  Scryfall
//
//  Created by Alexander on 11.07.2021.
//

import Foundation
import Combine

final class FileCache {

    // MARK: - Private

    private let baseCacheUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!

    private var pendingDownloads = [URL: AnyPublisher<URL, URLError>]()

    // MARK: - Init

    init() {
        let imagesPath = baseCacheUrl.appendingPathComponent("images")
        if !FileManager.default.fileExists(atPath: imagesPath.path) {
            try! FileManager.default.createDirectory(at: imagesPath, withIntermediateDirectories: false, attributes: nil)
        }
    }

    // MARK: - API

    func localUrl(for url: URL) -> AnyPublisher<URL, URLError> {
        let path = localPath(for: url)
        if FileManager.default.fileExists(atPath: path.path) {
            return Just(path)
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()
        } else if let download = pendingDownloads[url] {
            return download
        } else {
            let downloadPublisher = URLSession.shared
                .dataTaskPublisher(for: url)
                .print()
                .handleEvents(
                    receiveOutput: { output in
                        try? output.data.write(to: path)
                    },
                    receiveCompletion: { [weak self] _ in
                        self?.pendingDownloads[url] = nil
                    }
                )
                .map { _ in path }
                .share()
                .eraseToAnyPublisher()

            pendingDownloads[url] = downloadPublisher

            return downloadPublisher
        }
    }

    // MARK: - Private

    private func localPath(for url: URL) -> URL {
        let lastPathComponent = url.lastPathComponent
        return baseCacheUrl
            .appendingPathComponent("images")
            .appendingPathComponent(lastPathComponent)
    }
}
