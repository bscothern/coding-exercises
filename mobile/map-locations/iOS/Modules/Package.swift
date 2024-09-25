// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Modules",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        .library(
            name: "App",
            targets: ["App"]
        ),
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .target(name: "Common"),
                .target(name: "Resources"),
            ]
        ),
        .testTarget(
            name: "AppTests",
            dependencies: ["App"]
        ),
        .target(
            name: "Common"
        ),
        .testTarget(
            name: "CommonTests",
            dependencies: ["Common"]
        ),
        .target(
            name: "Resources",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
