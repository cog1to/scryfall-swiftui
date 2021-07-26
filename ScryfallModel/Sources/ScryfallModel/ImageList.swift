import Foundation

public final class ImageList: Codable {
    public let png: URL?
    public let borderCrop: URL?
    public let artCrop: URL?
    public let large: URL?
    public let normal: URL?
    public let small: URL?

    enum CodingKeys: String, CodingKey {
        case png = "png"
        case borderCrop = "border_crop"
        case artCrop = "art_crop"
        case large = "large"
        case normal = "normal"
        case small = "small"
    }
}
