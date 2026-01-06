// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftEncoders",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_13),
        .watchOS(.v4),
        .tvOS(.v12)
    ],
    products: [
        .library(
            name: "DictionaryEncoder",
            targets: ["DictionaryEncoder"]),
        .library(
            name: "QueryStringEncoder",
            targets: ["QueryStringEncoder"]),
    ],
    targets: [
        .target(
            name: "DictionaryEncoder"),
        .testTarget(
            name: "DictionaryEncoderTests",
            dependencies: ["DictionaryEncoder"]),
        .target(
            name: "QueryStringEncoder"
        ),
        .testTarget(
            name: "QueryStringEncoderTests",
            dependencies: ["QueryStringEncoder"]
        )
    ],
    swiftLanguageModes: [.v6, .v5]
)
