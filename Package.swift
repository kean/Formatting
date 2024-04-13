// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "Formatting",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
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
