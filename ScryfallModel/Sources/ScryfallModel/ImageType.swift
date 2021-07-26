//
//  ImageType.swift
//  
//
//  Created by Alexander on 26.06.2021.
//

import Foundation

public enum ImageType: String, Codable {
    case png = "png"
    case borderCrop = "border_crop"
    case art_crop = "art_crop"
    case large = "large"
    case normal = "normal"
    case small = "small"
}
