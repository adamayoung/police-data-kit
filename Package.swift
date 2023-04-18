// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PoliceAPI",

    platforms: [
        .macOS(.v12), .iOS(.v15), .tvOS(.v15), .watchOS(.v8)
    ],

    products: [
        .library(
            name: "PoliceAPI",
            targets: ["PoliceAPI"]
        )
    ],

    dependencies: [
        .package(url: "https://github.com/scinfu/SwiftSoup.git", .upToNextMajor(from: "2.5.3")),
        .package(url: "https://github.com/apple/swift-docc-plugin.git", from: "1.2.0")
    ],

    targets: [
        .target(
            name: "PoliceAPI",
            dependencies: ["SwiftSoup"]
        ),
        .testTarget(
            name: "PoliceAPITests",
            dependencies: ["PoliceAPI"],
            resources: [
                .process("Resources")
            ]
        )
    ]
)
