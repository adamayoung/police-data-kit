# Police Data Kit

[![CI](https://github.com/adamayoung/police-data-kit/actions/workflows/ci.yml/badge.svg)](https://github.com/adamayoung/police-data-kit/actions/workflows/ci.yml) [![Documentation](https://github.com/adamayoung/police-data-kit/actions/workflows/documentation.yml/badge.svg)](https://github.com/adamayoung/police-data-kit/actions/workflows/documentation.yml)

A Swift Package for retrieving open data about crime and policing in England, Wales and Northern Ireland.

## Requirements

* Swift 5.7+

## Installation

### [Swift Package Manager](https://github.com/apple/swift-package-manager)

Add the PoliceDataKit package as a dependency to your `Package.swift` file, and add it as a dependency to your target.

```swift
// swift-tools-version:5.7

import PackageDescription

let package = Package(
  name: "MyProject",

  dependencies: [
    .package(url: "https://github.com/adamayoung/police-data-kit.git", from: "3.0.0")
  ],

  targets: [
    .target(name: "MyProject", dependencies: [.product(name: "police-data-kit", package: "PoliceDataKit")])
  ]
)
```

### Xcode project

Add the PoliceDataKit package to your Project's Package dependencies.

## Topics

### Availability

Provides an interface for obtaining availability data sets from the UK Police Data API.

```swift
let availabilityService = AvailabilityService()
```

### Crimes

Provides an interface for obtaining crime data from the UK Police Data API.

```swift
let crimeService = CrimeService()
```

### Neighbourhoods

Provides an interface for obtaining neighbour data from the UK Police Data API.

```swift
let neighbourhoodService = NeighbourhoodService()
```

### Outcomes

Provides an interface for obtaining outcome data from the UK Police Data API.

```swift
let outcomeService = OutcomeService()
```

### Police Forces

Provides an interface for obtaining police force data from the UK Police Data API.

```swift
let policeForceService = PoliceForceService()
```

### Stop and Searches

Provides an interface for obtaining stop and search data from the UK Police Data API.

```swift
let stopAndSearchService = StopAndSearchService()
```

## Examples

### Fetch street level crimes in the centre of London

```swift
import CoreLocation
import Foundation
import PoliceDataKit

let crimeService = CrimeService()

let londonCoordinate = CLLocationCoordinate2D(latitude: 51.5072, longitude: 0.1276)

let crimes = try await crimeService.streetLevelCrimes(at: londonCoordinate)
```

### Fetch all Police Forces in England, Wales and Northern Ireland

```swift
import Foundation
import PoliceDataKit

let policeForceService = PoliceForceService()

let policeForces = try await policeForceService.policeForces()
```

## References

* [https://data.police.uk](https://data.police.uk)
