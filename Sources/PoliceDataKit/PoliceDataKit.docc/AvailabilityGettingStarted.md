# Getting Started with Availability

Learn how to fetch availability data sets from the UK Police Data API.

## Overview

Availability data sets allows you find out what data is available from what Police Forces.

### Create the Service

```swift
let availabilityService = AvailabilityService()
```

### Fetch the available data sets

```swift
let dataSets = try await availabilityService.availableDataSets()
```
