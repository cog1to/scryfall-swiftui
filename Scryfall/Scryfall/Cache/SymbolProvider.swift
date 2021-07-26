//
//  SymbolProvider.swift
//  Scryfall
//
//  Created by Alexander on 18.07.2021.
//

import Foundation
import UIKit
import SwiftUI
import Combine

protocol SymbolProvider: AnyObject {
    func image(forSymbol: String) -> AnyPublisher<UIImage, Never>
}
