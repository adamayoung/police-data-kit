// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PoliceDataKit",

    defaultLocalization: "en",

    platforms: [
        .macOS(.v12),
        .iOS(.v15),
        .tvOS(.v15),
        .watchOS(.v8)
    ],

    products: [
        .library(
            name: "PoliceDataKit",
            targets: ["PoliceDataKit"]
        )
    ],

    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin.git", from: "1.2.0")
    ],

    targets: [
        .target(
            name: "PoliceDataKit",
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "PoliceDataKitTests",
            dependencies: ["PoliceDataKit"],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "IntegrationTests",
            dependencies: ["PoliceDataKit"]
        )
    ]
)
