# Migrating from PoliceDataKit 4 to 5

Upgrade your PoliceDataKit dependency from 4.x to 5.0.

## Overview

PoliceDataKit 5.0 modernises the package for Swift 6, removes the Combine `*Publisher` API,
introduces typed-throws on every public service method, and raises the supported platform
versions. This guide describes the changes you'll need to make.

## Platform Requirements

The minimum supported platform versions have been raised:

| Platform | Version 4.x | Version 5.0 |
|----------|-------------|-------------|
| macOS    | 12+         | 14+         |
| iOS      | 15+         | 17+         |
| tvOS     | 15+         | 17+         |
| watchOS  | 8+          | 10+         |

A **Swift 6 toolchain (Xcode 16 or later)** is required to build PoliceDataKit 5.0.

The package itself compiles with `swiftLanguageMode(.v6)` on all its targets. Consumers
can still target an earlier Swift language mode in their own project settings — the
requirement is only for the toolchain version, not the language mode you choose in your app.

## Removed Combine API

All `*Publisher` methods have been removed. Replace them with their `async`/`await`
equivalents listed below.

| Removed (4.x)                                                        | Replacement (5.0)                                              |
|----------------------------------------------------------------------|----------------------------------------------------------------|
| `CrimeService.streetLevelCrimesPublisher(at:date:)`                  | ``CrimeService/streetLevelCrimes(at:date:)``                   |
| `CrimeService.streetLevelCrimesPublisher(in:date:)`                  | ``CrimeService/streetLevelCrimes(in:date:)``                   |
| `CrimeService.crimesPublisher(at:date:)`                             | ``CrimeService/crimes(at:date:)``                              |
| `OutcomeService.streetLevelOutcomesPublisher(at:date:)`              | ``OutcomeService/streetLevelOutcomes(at:date:)``               |
| `OutcomeService.streetLevelOutcomesPublisher(in:date:)`              | ``OutcomeService/streetLevelOutcomes(in:date:)``               |
| `NeighbourhoodService.neighbourhoodPublisher(at:)`                   | ``NeighbourhoodService/neighbourhood(at:)``                    |
| `NeighbourhoodService.neighbourhoodPolicingTeamPublisher(at:)`       | ``NeighbourhoodService/neighbourhoodPolicingTeam(at:)``        |
| `StopAndSearchService.stopAndSearchesPublisher(at:date:)`            | ``StopAndSearchService/stopAndSearches(at:date:)``             |
| `StopAndSearchService.stopAndSearchesPublisher(in:date:)`            | ``StopAndSearchService/stopAndSearches(in:date:)``             |

### Before and After

```swift
// Before (4.x)
crimeService.streetLevelCrimesPublisher(at: coordinate)
    .sink(receiveCompletion: { _ in }, receiveValue: { crimes in
        // …
    })
    .store(in: &cancellables)

// After (5.0)
do {
    let crimes = try await crimeService.streetLevelCrimes(at: coordinate)
    // …
} catch {
    // …
}
```

If you have existing `AnyCancellable` storage for these publishers, it is no longer
needed and can be removed.

## Typed Throws

All public service methods now declare typed throws, meaning the compiler knows the
precise error type at each call site. You no longer need a catch-all clause for
unreachable cases.

```swift
// Before (4.x)
do {
    let crimes = try await crimeService.crimes(at: coordinate)
} catch let error as CrimeError {
    switch error { /* … */ }
} catch {
    // unreachable, but the compiler insists
}

// After (5.0)
do {
    let crimes = try await crimeService.crimes(at: coordinate)
} catch {
    // `error` is statically typed as CrimeError
    switch error { /* … */ }
}
```

The typed error for each service is:

| Service                   | Error type               |
|---------------------------|--------------------------|
| ``CrimeService``          | ``CrimeError``           |
| ``OutcomeService``        | ``OutcomeError``         |
| ``NeighbourhoodService``  | ``NeighbourhoodError``   |
| ``PoliceForceService``    | ``PoliceForceError``     |
| ``StopAndSearchService``  | ``StopAndSearchError``   |
| ``AvailabilityService``   | ``AvailabilityError``    |

Each error type is a `Sendable` enum. The common cases are:

- `notFound` — the API returned a 404 response.
- `network(_:)` — a transport-level failure; the associated value is the underlying `Error`.
- `unknown` — an unexpected response or decode failure.

Services that validate coordinate inputs also add:

- `locationOutsideOfDataSetRegion` — the supplied coordinate falls outside England, Wales,
  or Northern Ireland and no API call was made.

This case applies to ``CrimeService``, ``OutcomeService``, ``NeighbourhoodService``, and
``StopAndSearchService``.

## New APIs

### `CrimeService.latestDataDate()`

Returns the most recent month for which crime data is available, sourced from the
`/crime-last-updated` endpoint.

```swift
let latestDate = try await crimeService.latestDataDate()
```

### `NeighbourhoodService.events(forNeighbourhood:inPoliceForce:)`

Returns neighbourhood events for a given neighbourhood and police force. The response
is an array of the new ``NeighbourhoodEvent`` model.

```swift
let events = try await neighbourhoodService.events(
    forNeighbourhood: "NC04",
    inPoliceForce: "leicestershire"
)
```

### `EngagementMethod.type`

``EngagementMethod`` now exposes an optional `type` property (a `String`) that surfaces
the kind of engagement method as provided by the API.

## Sendable Conformance

All public models and error types now conform to `Sendable`. If you previously crossed
an actor boundary and worked around missing conformance with `@unchecked Sendable`
wrappers on PoliceDataKit types, those workarounds can now be removed.

## Internal Changes Worth Knowing

These are not public API, but may affect advanced integrations or forks:

- `PoliceDataKitFactory` is now an `enum` with `static let` properties, ensuring a
  single shared cache instance per process. The previous class-based implementation
  has been removed.
- The shared `URLSession` is configured with `waitsForConnectivity = true`, a 30-second
  timeout, and — on iOS — `multipathServiceType = .handover`. This behaviour is unchanged
  from 4.x.

## See Also

- <doc:GettingStartedWithCrimes>
- <doc:GettingStartedWithOutcomes>
- <doc:GettingStartedWithNeighbourhoods>
- <doc:GettingStartedWithPoliceForces>
- <doc:GettingStartedWithStopAndSearches>
- <doc:GettingStartedWithAvailability>
