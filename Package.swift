// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "Formatting",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v12),
        .tvOS(.v12),
        .watchOS(.v5)
    ],
    products: [
        .library(name: "Formatting", targets: ["Formatting"])
    ],
    dependencies: [],
    targets: [
        .target(name: "Formatting", dependencies: [], path: "Source"),
        .testTarget(name: "FormattingTests", dependencies: ["Formatting"], path: "Tests")
    ]
)
