# UK Police Data

![CI](https://github.com/adamayoung/UKPoliceData/workflows/CI/badge.svg)

A Swift Package for UK Police data which provides a rich data source for information about crime and policing in England, Wales and Northern Ireland.

## Requirements

* Swift 5.7+

## Installation

### [Swift Package Manager](https://github.com/apple/swift-package-manager)

Add the UKPoliceData package as a dependency to your `Package.swift` file, and add it as a dependency to your target.

```swift
// swift-tools-version:5.7

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
