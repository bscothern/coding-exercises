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
        ),
        .library(
            name: "AppLive",
            targets: ["AppLive"]
        ),
    ],
    targets: [
        // Main target
        .target(
            name: "AppLive",
            dependencies: [
                .target(name: "App"),
                .target(name: "APILive"),
            ]
        ),
        .target(
            name: "App",
            dependencies: [
                .target(name: "API"),
                .target(name: "Common"),
                .target(name: "Resources"),
            ]
        ),
        // Other targets
        .target(
            name: "API"
        ),
        .target(
            name: "APILive",
            dependencies: [
                .target(name: "API"),
                .target(name: "Common"),
            ]
        ),
        .testTarget(
            name: "APILiveTests",
            dependencies: [
                .target(name: "APILive"),
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
