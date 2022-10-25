// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UKPoliceData",

    platforms: [
        .macOS(.v12), .iOS(.v15), .tvOS(.v15), .watchOS(.v8)
    ],

    products: [
        .library(
            name: "UKPoliceData",
            targets: ["UKPoliceData"]
        )
    ],

    dependencies: [
        .package(url: "https://github.com/scinfu/SwiftSoup.git", .upToNextMajor(from: "2.3.2")),
        .package(url: "https://github.com/apple/swift-docc-plugin.git", from: "1.0.0")
    ],

    targets: [
        .target(
            name: "UKPoliceData",
            dependencies: ["SwiftSoup"]
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
