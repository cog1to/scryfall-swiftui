//
//  ImageCache.swift
//  Scryfall
//
//  Created by Alexander on 11.07.2021.
//

import Foundation
import Combine

final class ImageCache {

    // MARK: - Private

    private let baseCacheUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!

    private var pendingDownloads = [URL: AnyPublisher<URL, URLError>]()

    private let manager = FileManager.default

    // MARK: - Init

    init() {
        let imagesPath = baseCacheUrl.appendingPathComponent("images")
        if !manager.fileExists(atPath: imagesPath.path) {
            try! manager.createDirectory(at: imagesPath, withIntermediateDirectories: false, attributes: nil)
        }
    }

    // MARK: - API

    func immediateLocalUrl(for url: URL) -> URL? {
        let path = localPath(for: url)
        if manager.fileExists(atPath: path.path) {
            return path
        } else {
            return nil
        }
    }

    func localUrl(for url: URL) -> AnyPublisher<URL, URLError> {
        let path = localPath(for: url)

        if manager.fileExists(atPath: path.path),
           let attributes = try? manager.attributesOfItem(atPath: path.path),
           let creationDate = attributes[FileAttributeKey.creationDate] as? Date,
           creationDate > (Date().addingTimeInterval(TimeInterval(-cacheExpiration)))
        {
            return Just(path)
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()
        }

        if let download = pendingDownloads[url] {
            return download
        }

        let downloadPublisher = URLSession.shared
            .dataTaskPublisher(for: url)
            .handleEvents(
                receiveOutput: { [manager] output in
                    let pathToDirectory = path.deletingLastPathComponent()
                    if !manager.fileExists(atPath: pathToDirectory.path) {
                        try? manager.createDirectory(
                            at: pathToDirectory,
                            withIntermediateDirectories: true,
                            attributes: nil
                        )
                    }

                    let data: Data = {
                        return output.data
                    }()

                    try? data.write(to: path)
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

    // MARK: - Private

    private func localPath(for url: URL) -> URL {
        let path = url.pathComponents.dropFirst(2).joined(separator: "/")
        return baseCacheUrl
            .appendingPathComponent("images")
            .appendingPathComponent(path)
    }

    // MARK: - Constants

    let cacheExpiration: Double = 60 * 60 * 24 * 7 // 1 week
}
