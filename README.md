# UK Police Data

[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager) ![platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS%20%7C%20Linux-333333.svg)

A Swift Package for UK Police data which provides a rich data source for information about crime and policing in England, Wales and Northern Ireland.

## Requirements

* Swift 5.3+

## Installation

### [Swift Package Manager](https://github.com/apple/swift-package-manager)

Add the UKPoliceData package as a dependency to your `Package.swift` file, and add it as a dependency to your target.

```swift
// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "MyProject",

  dependencies: [
    .package(url: "https://github.com/adamayoung/UKPoliceData.git", from: "1.0.0")
  ],

  targets: [
    .target(name: "MyProject", dependencies: ["UKPoliceData"])
  ]
)
```

## References

* [https://data.police.uk](https://data.police.uk)
