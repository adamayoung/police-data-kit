# Getting Started with Availability

Learn how to fetch availability data sets from the UK Police API.

## Overview

Availability data sets allows you find out what data is available from what Police Force.

### Create the Service

```swift
import PoliceDataKit

let availabilityService = AvailabilityService()
```

### Available data sets

```swift
let dataSets = try await availabilityService.availableDataSets()
```
