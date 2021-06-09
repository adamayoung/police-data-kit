# UK Police Data

![CI](https://github.com/adamayoung/UKPoliceData/workflows/Mainline/badge.svg) [![Coverage](https://sonarcloud.io/api/project_badges/measure?project=adamayoung_UKPoliceData&metric=coverage)](https://sonarcloud.io/dashboard?id=adamayoung_UKPoliceData) [![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=adamayoung_UKPoliceData&metric=alert_status)](https://sonarcloud.io/dashboard?id=adamayoung_UKPoliceData) [![Security Rating](https://sonarcloud.io/api/project_badges/measure?project=adamayoung_UKPoliceData&metric=security_rating)](https://sonarcloud.io/dashboard?id=adamayoung_UKPoliceData)

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
