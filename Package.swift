// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PoliceDataKit",

    defaultLocalization: "en",

    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .tvOS(.v16),
        .watchOS(.v9)
    ],

    products: [
        .library(
            name: "PoliceDataKit",
            targets: ["PoliceDataKit"]
        )
    ],

    dependencies: [
        .package(url: "https://github.com/scinfu/SwiftSoup.git", .upToNextMajor(from: "2.6.0")),
        .package(url: "https://github.com/apple/swift-docc-plugin.git", from: "1.2.0"),
        .package(url: "https://github.com/adamayoung/swiftlint-plugin.git", from: "0.51.0")
    ],

    targets: [
        .target(
            name: "PoliceDataKit",
            dependencies: ["SwiftSoup"],
            resources: [
                .process("Resources")
            ],
            plugins: [
                .plugin(name: "SwiftLintPlugin", package: "swiftlint-plugin")
            ]
        ),
        .testTarget(
            name: "PoliceDataKitTests",
            dependencies: ["PoliceDataKit"],
            resources: [
                .process("Resources")
            ],
            plugins: [
                .plugin(name: "SwiftLintPlugin", package: "swiftlint-plugin")
            ]
        )
    ]
)
