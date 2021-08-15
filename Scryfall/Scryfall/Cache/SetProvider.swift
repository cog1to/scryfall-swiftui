//
//  SetProvider.swift
//  Scryfall
//
//  Created by Alexander on 13.08.2021.
//

import Foundation
import UIKit
import SwiftUI
import Combine

protocol SetProvider: AnyObject {
    func image(forSet: String) -> AnyPublisher<UIImage, Never>
}
