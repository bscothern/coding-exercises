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
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections", from: "1.0.2"),
        .package(url: "https://github.com/bscothern/swiftui-preview-bundle-finder", .upToNextMinor(from: "0.2.0")),
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
                .product(name: "Collections", package: "swift-collections")
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
            dependencies: [
                .product(name: "SwiftUIPreviewBundleFinder", package: "swiftui-preview-bundle-finder")
            ],
            resources: [
                .process("R"),
            ]
        ),
    ]
)
