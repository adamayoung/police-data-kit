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
            dependencies: [
                "PoliceAPIDomain",
                "PoliceAPIData",
                "Networking",
                "Caching"
            ]
        ),
        .testTarget(
            name: "PoliceAPITests",
            dependencies: ["PoliceAPI"]
        ),

        .target(
            name: "PoliceAPIDomain"
        ),
        .testTarget(
            name: "PoliceAPIDomainTests",
            dependencies: ["PoliceAPIDomain"]
        ),

        .target(
            name: "PoliceAPIData",
            dependencies: [
                "PoliceAPIDomain",
                "SwiftSoup"
            ]
        ),
        .testTarget(
            name: "PoliceAPIDataTests",
            dependencies: ["PoliceAPIData"],
            resources: [
                .process("Resources")
            ]
        ),

        .target(
            name: "Networking",
            dependencies: [
                "PoliceAPIData"
            ]
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]
        ),

        .target(
            name: "Caching",
            dependencies: [
                "PoliceAPIData"
            ]
        ),
        .testTarget(
            name: "CachingTests",
            dependencies: ["Caching"]
        )
    ]
)
