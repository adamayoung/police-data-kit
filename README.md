# UK Police Data

![CI](https://github.com/adamayoung/UKPoliceData/workflows/CI/badge.svg)

A Swift Package for UK Police data which provides a rich data source for information about crime and policing in England, Wales and Northern Ireland.

## Requirements

* Swift 5.7+

## Installation

### [Swift Package Manager](https://github.com/apple/swift-package-manager)

Add the PoliceAPI package as a dependency to your `Package.swift` file, and add it as a dependency to your target.

```swift
// swift-tools-version:5.7

import PackageDescription

let package = Package(
  name: "MyProject",

  dependencies: [
    .package(url: "https://github.com/adamayoung/police-api.git", from: "2.0.0")
  ],

  targets: [
    .target(name: "MyProject", dependencies: [.product(name: "police-api", package: "PoliceAPI")])
  ]
)
```

## API Areas

### Availability

Information about availability of data.

### Crimes

Information about a Crimes.

### Neighbourhoods

Information about a Police Force Neighbourhoods.

### Outcomes

Information about a Crime's Outcome.

### Police Forces

Information about Police Forces and their Senior Officers.

### Stop and Searches

Information about Stop and Searches.

## References

* [https://data.police.uk](https://data.police.uk)
