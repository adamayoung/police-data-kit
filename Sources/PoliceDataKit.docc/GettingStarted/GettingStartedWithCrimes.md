# Getting Started with Crimes

Learn how to fetch crime data from the UK Police API.

## Overview

You can find lists of crimes at street level and surrounding areas, along with
crimes without a location and crime categories.

### Create the Service

```swift
import PoliceDataKit

let crimeService = CrimeService()
```

### Finding Street Level Crimes

Crimes can be found within a 1 mile radius of a location using ``CrimeService/streetLevelCrimes(at:date:)``.

```swift
let centralLondonCoordinate = CLLocationCoordinate2D(latitude: 51.5072, 0.1275)

let crimes = try await crimeService.streetLevelCrimes(at: centralLondonCoordinate)
```

> Tip: You can include a `date` parameter to find crimes within a 1 mile radius
for a particular month.

Or within a defined boundary (a collection of CLLocationCoordinate2Ds) using
``CrimeService/streetLevelCrimes(in:date:)``.

```swift
let boundary = [
   CLLocationCoordinate2D(latitude: 51.507, longitude: 0.127),
   CLLocationCoordinate2D(latitude: 51.508, longitude: 0.127),
   CLLocationCoordinate2D(latitude: 51.508, longitude: 0.128),
   CLLocationCoordinate2D(latitude: 51.507, longitude: 0.128),
   CLLocationCoordinate2D(latitude: 51.507, longitude: 0.127)
]

let crimes = try await crimeService.streetLevelCrimes(in: boundary)
```

> Tip: You can include a `date` parameter to find crimes in a defined boundary
for a particular month.

### Finding Crimes at a specific location

Crimes can be found for a specific street using ``CrimeService/crimes(forStreet:date:)``.

For example, to find all crimes for the current month on
[Saunders Way, London](https://maps.apple.com/?address=Saunders%20Way,%20London,%20SE28,%20England&ll=51.507081,0.112754&q=Saunders%20Way):

```swift
let saundersWayLondonStreetID = 1705005

let crimes = try await crimeService.crimes(forStreet: saundersWayLondonStreetID)
```

> Tip: You can include a `date` parameter to find crimes for a specific street
for a particular month.

Or crimes at be found on a single street closest to a location using ``CrimeService/crimes(at:date:)``.

```swift
let coordinate = CLLocationCoordinate2D(
   latitude: 51.507081,
   longitude: 0.112754
)

let crimes = try await crimeService.crimes(at: coordinate)
```

> Tip: You can include a `date` parameter to find crimes for location for a
particular month.

### Finding Crimes with no Location

Not all crimes have a location associated with them. ``CrimeService/crimesWithNoLocation(forCategory:inPoliceForce:date:)``
can be used to find these.

For example, to find crimes with no location in
[Nottinghamshire](https://maps.apple.com/?address=Nottinghamshire,%20England&auid=6251376984914636760&ll=53.144044,-1.032144&lsp=6489&q=Nottinghamshire):

```swift
let policeForceID = "nottinghamshire"

let crimes = try await crimeService.crimesWithNoLocation(inPoliceForce: policeForceID)
```

> Tip: You can filter on the type of crime by using the `category` parameter,
and include a `date` parameter to find crimes with no location for a particular month.

### Getting a list of all Crime Categories

Each crime is categorised by the type crime that took place. The full list of
available categories can be fetched using ``CrimeService/crimeCategories(forDate:)``.

```swift
let categories = try await crimeService.crimeCategories()
```

> Tip: You can include a `date` parameter to get crime categories for a
particular month.
