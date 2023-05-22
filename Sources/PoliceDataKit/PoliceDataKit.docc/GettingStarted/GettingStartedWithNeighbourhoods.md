# Getting Started with Neighbourhoods

Learn how to fetch neighbourhood data from the UK Police API.

## Overview

You can find lists of crimes at street level and surrounding areas, along with crimes without a location.

### Create the Service

```swift
import PoliceDataKit

let neighbourhoodService = NeighbourhoodService()
```

### Fetching Neighbourhoods in a Police Force

Neighbourhoods in a particular police force can be found using ``NeighbourhoodService/neighbourhoods(inPoliceForce:)``.

For example, to find all the neighbourhoods in
 [Leicestershire](https://maps.apple.com/?address=Leicestershire,%20England&auid=9613554324616554887&ll=52.772459,-1.207841&lsp=6489&q=Leicestershire):

```swift
let leicestershirePoliceForceID = "leicestershire"

let neighbourhoods = try await neighbourhoodService.neighbourhoods(inPoliceForce: leicestershirePoliceForceID)
```

To fetch a specific neighbourhood with all its data can be done with
``NeighbourhoodService/neighbourhood(withID:inPoliceForce:)``.

For example, to fetch the city centre neighbourhood in
[Leicestershire](https://maps.apple.com/?address=Leicestershire,%20England&auid=9613554324616554887&ll=52.772459,-1.207841&lsp=6489&q=Leicestershire):

```swift
let leicesterCityCentreNeighbourhoodID = "NC04"
let leicestershirePoliceForceID = "leicestershire"

let neighbourhood = try await neighbourhoodService.neighbourhood(withID: leicesterCityCentreNeighbourhoodID, inPoliceForce: leicestershirePoliceForceID)
```

A neighbourhood at a specific coordinate can also be found with ``NeighbourhoodService/neighbourhood(at:)``.

For example, to find the neighbourhood for
[Leeds City Centre](https://maps.apple.com/?address=7%20King%20Edward%20St,%20Leeds,%20LS1%206AX,%20England&auid=1817029011196917833&ll=53.797927,-1.541522&lsp=9902&q=Leeds%20City%20Centre):

```swift
let leedsCityCentreCoordinate = CLLocationCoordinate2D(latitude: 53.797927, longitude: -1.541522)

let neighbourhood = try await neighbourhoodService.neighbourhood(at: leedsCityCentreCoordinate)
```

### Fetching a Neighbourhood's Boundary

The boundary (a collection of `CLLocationCoordinate2D`s) of a neighbourhood can be found with ``NeighbourhoodService/boundary(forNeighbourhood:inPoliceForce:)``.

For example, to find the boundary of
[Doncaster West](https://maps.apple.com/?address=Doncaster,%20England&auid=4220681771952713718&ll=53.521011,-1.130664&lsp=6489&q=Doncaster)
neighbourhood in
[Yorkshire](https://maps.apple.com/?address=Yorkshire,%20England&auid=4203083994099674493&ll=53.700746,-0.995171&lsp=6489&q=Yorkshire):

```swift
let doncasterWestNeighbourhoodID = "AB"
let yorkshirePoliceForceID = "south-yorkshire"

let boundary = try await neighbourhoodService.boundary(forNeighbourhood: doncasterWestNeighbourhoodID, inPoliceForce: yorkshirePoliceForceID)
```

### Fetching the Police Officers for a Neighbourhood

The police officers who are members of the neighbourhood team for a neighbour can be fetched with ``NeighbourhoodService/policeOfficers(forNeighbourhood:inPoliceForce:)``.

For example, to find the police officers for
[Leamington Town Centre](https://maps.apple.com/?address=Leamington%20Spa,%20England&auid=15800149488666726483&ll=52.289138,-1.535247&lsp=6489&q=Leamington%20Spa)
neighbourhood in
[Warwickshire](https://maps.apple.com/?address=Warwickshire,%20England&auid=2687946884610741780&ll=52.327029,-1.558407&lsp=6489&q=Warwickshire):

```swift
let leamingtonTownCentreNeighbourhoodID = "lstc"
let warwickshirePoliceForceID = "warwickshire"

let boundary = try await neighbourhoodService.policeOfficers(forNeighbourhood: leamingtonTownCentreNeighbourhoodID, inPoliceForce: warwickshirePoliceForceID)
```

### Fetching Priorities for a Neighbourhood

Priorities for a neighbourhood can be fetched with ``NeighbourhoodService/priorities(forNeighbourhood:inPoliceForce:)``.

For example, to find the priorties for
[Grantham Town Centre](https://maps.apple.com/?address=Grantham,%20South%20Kesteven,%20England&auid=5085348895874575037&ll=52.912698,-0.640480&lsp=6489&q=Grantham)
neighbourhood in
[Lincolnshire](https://maps.apple.com/?address=Lincolnshire,%20England&auid=11757345785407347068&ll=53.231033,-0.544142&lsp=6489&q=Lincolnshire):

```swift
let granthamTownCentreNeighbourhoodID = "NC44"
let lincolnshirePoliceForceID = "lincolnshire"

let boundary = try await neighbourhoodService.policeOfficers(forNeighbourhood: granthamTownCentreNeighbourhoodID, inPoliceForce: lincolnshirePoliceForceID)
```

### Fetching the Police Team for a Neighbourhood

The neighbourhood policing team responsible for a particular area can be fetched with ``NeighbourhoodService/neighbourhoodPolicingTeam(at:)`` or
``NeighbourhoodService/neighbourhoodPolicingTeamPublisher(at:)``.

For example, to find the policing team for
[Leeds City Centre](https://maps.apple.com/?address=7%20King%20Edward%20St,%20Leeds,%20LS1%206AX,%20England&auid=1817029011196917833&ll=53.797927,-1.541522&lsp=9902&q=Leeds%20City%20Centre):

```swift
let leedsCityCentreCoordinate = CLLocationCoordinate2D(latitude: 53.797927, longitude: -1.541522)

let policingTeam = try await neighbourhoodService.neighbourhoodPolicingTeam(at: leedsCityCentreCoordinate)
```

```swift
neighbourhoodService.neighbourhoodPolicingTeamPublisher(at: leedsCityCentreCoordinate)
    .sink {
        ...
    }
    
```
