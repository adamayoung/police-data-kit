# Getting Started with Police Forces

Learn how to fetch police force data from the UK Police API.

## Overview

You can find information about Police Forces and Senior Officers for a People Force.

### Create the Service

```swift
import PoliceDataKit

let policeForceService = PoliceForceService()
```

### Fetching all Police Forces

All Police Forces in the UK can be fetched using ``PoliceForceService/policeForces()``. 

```swift
let policeForces = try await policeForceService.policeForces()
```

### Fetching a specific Police Force

Fetching a specific Police Force and all its details can be fetched using ``PoliceForceService/policeForce(withID:)``.

```swift
let policeForceID = "west-yorkshire"

let policeForce = try await policeForceService.policeForce(withID: policeForceID)
```

### Fetching the Senior Police Officers for a Police Force

The Senior Police Officers for a Police Force can be found using ``PoliceForceService/seniorOfficers(inPoliceForce:)``.

```swift
let policeForceID = "avon-and-somerset"

let seniorOfficers = try await policeForceService.seniorOfficers(inPoliceForce: policeForceID)
```
