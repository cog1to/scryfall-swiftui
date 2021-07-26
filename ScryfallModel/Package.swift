// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ScryfallModel",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "ScryfallModel",
            targets: ["ScryfallModel"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "ScryfallModel",
            dependencies: []),
        .testTarget(
            name: "ScryfallModelTests",
            dependencies: ["ScryfallModel"]),
    ]
)
