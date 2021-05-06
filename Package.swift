// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UKPoliceData",

    platforms: [
        .macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)
    ],

    products: [
        .library(
            name: "UKPoliceData",
            targets: ["UKPoliceData"]
        )
    ],

    dependencies: [],

    targets: [
        .target(
            name: "UKPoliceData",
            dependencies: []
        ),
        .testTarget(
            name: "UKPoliceDataTests",
            dependencies: ["UKPoliceData"],
            resources: [
                .process("Resources")
            ]
        )
    ]
)
