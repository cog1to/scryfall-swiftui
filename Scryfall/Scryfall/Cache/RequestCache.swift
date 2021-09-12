//
//  RequestCache.swift
//  Scryfall
//
//  Created by Alexander on 12.09.2021.
//

import Foundation
import CryptoKit

final class RequestCache {

    // MARK: - Private

    private let baseCacheUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!

    private let manager = FileManager.default

    private var requestPath: URL {
        baseCacheUrl.appendingPathComponent("requests")
    }

    // MARK: - Init

    init() {
        let requestsPath = baseCacheUrl.appendingPathComponent("requests")
        if !manager.fileExists(atPath: requestsPath.path) {
            try! manager.createDirectory(at: requestsPath, withIntermediateDirectories: false, attributes: nil)
        }
    }

    func data(forURL url: URL) -> Data? {
        let hash = MD5(string: url.absoluteString)
        let fileURL = requestPath.appendingPathComponent(hash)

        if !manager.fileExists(atPath: requestPath.appendingPathComponent(hash).path) {
            return nil
        }

        let attributes = try? manager.attributesOfItem(atPath: fileURL.path)
        guard let creationDate = attributes?[FileAttributeKey.creationDate] as? Date,
              creationDate > (Date().addingTimeInterval(TimeInterval(-cacheExpiration)))
        else {
            return nil
        }

        return try? Data(contentsOf: fileURL)
    }

    func save(data: Data, forURL url: URL) {
        let hash = MD5(string: url.absoluteString)
        let fileURL = requestPath.appendingPathComponent(hash)

        do {
            if manager.fileExists(atPath: requestPath.appendingPathComponent(hash).path) {
                try manager.removeItem(at: fileURL)
            }
        } catch {
            print("Failed to remove url cache. Path: \(fileURL.path)")
            return
        }

        do {
            try data.write(to: fileURL)
        } catch {
            print("Failed to write response. URL: \"\(url.absoluteString)\", path: \(fileURL.path)")
        }
    }

    // MARK: - Hashing

    private func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8)!)
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }

    // MARK: - Constants

    let cacheExpiration: Double = 60 * 60 * 24 // 1 day
}
