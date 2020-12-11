// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Formatting",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v11),
        .tvOS(.v11),
        .watchOS(.v4)
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
