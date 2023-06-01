# PoliceDataKit

[![CI](https://github.com/adamayoung/police-data-kit/actions/workflows/ci.yml/badge.svg)](https://github.com/adamayoung/police-data-kit/actions/workflows/ci.yml)
[![Integration Tests](https://github.com/adamayoung/police-data-kit/actions/workflows/integration.yml/badge.svg)](https://github.com/adamayoung/police-data-kit/actions/workflows/integration.yml)
[![Documentation](https://github.com/adamayoung/police-data-kit/actions/workflows/documentation.yml/badge.svg)](https://github.com/adamayoung/police-data-kit/actions/workflows/documentation.yml)

A Swift Package for retrieving open data about crime and policing in England,
Wales and Northern Ireland.

## Requirements

* Swift 5.7+

## Installation

### [Swift Package Manager](https://github.com/apple/swift-package-manager)

Add the PoliceDataKit package as a dependency to your `Package.swift` file, and
add it as a dependency to your target.

```swift
// swift-tools-version:5.7

import PackageDescription

let package = Package(
  name: "MyProject",

  dependencies: [
    .package(url: "https://github.com/adamayoung/police-data-kit.git", from: "3.0.0")
  ],

  targets: [
    .target(
      name: "MyProject",
      dependencies: [
        .product(name: "police-data-kit", package: "PoliceDataKit")
      ]
    )
  ]
)
```

### Xcode project

Add the PoliceDataKit package to your Project's Package dependencies.

## Documentation

Documentation and examples of usage can be found at
[https://adamayoung.github.io/police-data-kit/documentation/policedatakit/](https://adamayoung.github.io/police-data-kit/documentation/policedatakit/)

## References

* [data.police.uk](https://data.police.uk)
* [Documentation](https://adamayoung.github.io/police-data-kit/documentation/policedatakit/)
