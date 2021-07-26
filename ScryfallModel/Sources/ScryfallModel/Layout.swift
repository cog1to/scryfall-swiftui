//
//  Layout.swift
//  
//
//  Created by Alexander on 26.06.2021.
//

import Foundation

public enum Layout: String, Decodable {
    case normal = "normal"
    case split = "split"
    case flip = "flip"
    case transform = "transform"
    case modalDoubleFacedCard = "modal_dfc"
    case meld = "meld"
    case leveler = "leveler"
    case saga = "saga"
    case adventure = "adventure"
    case planar = "planar"
    case scheme = "scheme"
    case vanguard = "vanguard"
    case token = "token"
    case doubleFacedToken = "double_faced_token"
    case emblem = "emblem"
    case augment = "augment"
    case host = "host"
    case artSeries = "art_series"
    case doubleSided = "double_sided"
}
