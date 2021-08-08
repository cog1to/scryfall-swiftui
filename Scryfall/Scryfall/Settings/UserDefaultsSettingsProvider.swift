//
//  UserDefaultsSettingsProvider.swift
//  Scryfall
//
//  Created by Alexander on 04.08.2021.
//

import Foundation

class UserDefaultsSettingsProvider: SettingsProvider {

    // MARK: Private

    private let userDefaults = UserDefaults.standard

    private enum Key: String {
        case presentationStyle
        case queryType
    }

    // MARK: - SettingsProvider

    var presentationStyle: PresentationStyle? {
        get {
            let val: PresentationStyle? = value(forKey: .presentationStyle)
            return val
        }
        set {
            setValue(newValue, forKey: .presentationStyle)
        }
    }

    var queryType: QueryType? {
        get {
            let val: QueryType? = value(forKey: .queryType)
            return val
        }
        set {
            setValue(newValue, forKey: .queryType)
        }
    }

    // MARK: - Private

    private func value<T: Codable>(forKey key: Key) -> T? {
        if let data = userDefaults.data(forKey: key.rawValue) {
            return try? JSONDecoder().decode(T.self, from: data)
        } else {
            return nil
        }
    }

    private func setValue<T: Codable>(_ value: T?, forKey key: Key) {
        guard let value = value else {
            userDefaults.removeObject(forKey: key.rawValue)
            return
        }

        if let data = try? JSONEncoder().encode(value) {
            userDefaults.set(data, forKey: key.rawValue)
        }
    }
}
