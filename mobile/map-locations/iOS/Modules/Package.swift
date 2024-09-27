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
    ],
    dependencies: [
        .package(url: "https://github.com/bscothern/swiftui-preview-bundle-finder", .upToNextMinor(from: "0.2.0")),
        .package(url: "https://github.com/pointfreeco/swift-identified-collections", from: "1.1.0"),
    ],
    targets: [
        // Main target
        .target(
            name: "App",
            dependencies: [
                .target(name: "Map"),
                .target(name: "APILive"),
            ]
        ),
        // Other targets
        .target(
            name: "API",
            dependencies: [
                .target(name: "Common"),
            ]
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
            name: "Common",
            dependencies: [
                .target(name: "Resources"),
            ]
        ),
        .testTarget(
            name: "CommonTests",
            dependencies: [
                .target(name: "Common"),
            ]
        ),
        .target(
            name: "FilterPins",
            dependencies: [
                .target(name: "Common"),
                .target(name: "ViewModifiers"),
            ]
        ),
        .target(
            name: "LocationDetail",
            dependencies: [
                .target(name: "Common"),
                .target(name: "Resources"),
                .target(name: "ViewModifiers"),
            ]
        ),
        .target(
            name: "Map",
            dependencies: [
                .target(name: "API"),
                .target(name: "Common"),
                .target(name: "FilterPins"),
                .target(name: "LocationDetail"),
                .target(name: "Resources"),
                .target(name: "ViewModifiers"),
                .product(name: "IdentifiedCollections", package: "swift-identified-collections")
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
        .target(
            name: "ViewModifiers",
            dependencies: [
                .target(name: "Resources"),
            ]
        ),
    ]
)
