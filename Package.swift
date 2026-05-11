// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import class Foundation.ProcessInfo
import PackageDescription

let package = Package(
    name: "PoliceDataKit",

    defaultLocalization: "en",

    platforms: [
        .macOS(.v14),
        .iOS(.v17),
        .tvOS(.v17),
        .watchOS(.v10)
    ],

    products: [
        .library(
            name: "PoliceDataKit",
            targets: ["PoliceDataKit"]
        )
    ],

    targets: [
        .target(
            name: "PoliceDataKit",
            resources: [
                .process("Resources")
            ],
            swiftSettings: [
                .swiftLanguageMode(.v6)
            ]
        ),
        .testTarget(
            name: "PoliceDataKitTests",
            dependencies: ["PoliceDataKit"],
            resources: [
                .process("Resources")
            ],
            swiftSettings: [
                .swiftLanguageMode(.v6)
            ]
        ),
        .testTarget(
            name: "IntegrationTests",
            dependencies: ["PoliceDataKit"],
            swiftSettings: [
                .swiftLanguageMode(.v6)
            ]
        )
    ]
)

if ProcessInfo.processInfo.environment["SWIFTCI_DOCC"] == "1" {
    package.dependencies += [
        .package(url: "https://github.com/apple/swift-docc-plugin.git", from: "1.4.0")
    ]
}
