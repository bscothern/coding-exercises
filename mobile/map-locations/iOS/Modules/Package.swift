// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Modules",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "App",
            targets: ["App"]
        )
    ],
    targets: [
        // Main target
        .target(
            name: "App",
            dependencies: [
                .target(name: "API"),
                .target(name: "Common"),
                .target(name: "Resources"),
            ]
        ),
        .testTarget(
            name: "AppTests",
            dependencies: [
                .target(name: "App")
            ]
        ),
        // Other targets
        .target(
            name: "API",
            dependencies: [
                .target(name: "Common"),
            ]
        ),
        .testTarget(
            name: "APITests",
            dependencies: [
                .target(name: "API"),
                .target(name: "Common"),
            ]
        ),
        .target(
            name: "Common"
        ),
        .testTarget(
            name: "CommonTests",
            dependencies: [
                .target(name: "Common"),
            ]
        ),
        .target(
            name: "Resources",
            resources: [
                .process("Resources"),
            ]
        )
    ]
)
