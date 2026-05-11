//
//  NeighbourhoodIntegrationTests.swift
//  PoliceDataKit
//
//  Copyright © 2024 Adam Young.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an AS IS BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import CoreLocation
import PoliceDataKit
import Testing

@Suite("Neighbourhood integration", .integrationGate, .tags(.integration))
struct NeighbourhoodIntegrationTests {

    let neighbourhoodService: NeighbourhoodService

    init() {
        self.neighbourhoodService = NeighbourhoodService()
    }

    @Test("neighbourhoods in police force for Norfolk Constabulary")
    func neighbourhoodsInPoliceForceForNorfolkConstabulary() async throws {
        let policeForceID = "norfolk"

        let neighbourhoods = try await retry {
            try await neighbourhoodService.neighbourhoods(inPoliceForce: policeForceID)
        }

        #expect(!neighbourhoods.isEmpty)
    }

    @Test("neighbourhoods in police force for North Wales Police")
    func neighbourhoodsInPoliceForceForNorthWalesPolice() async throws {
        let policeForceID = "north-wales"

        let neighbourhoods = try await retry {
            try await neighbourhoodService.neighbourhoods(inPoliceForce: policeForceID)
        }

        #expect(!neighbourhoods.isEmpty)
    }

    @Test("neighbourhoods in police force for invalid police force throws not found")
    func neighbourhoodsInPoliceForceForInvalidPoliceForce() async throws {
        let policeForceID = "ccc"

        var neighbourhoodError: NeighbourhoodError?
        do {
            _ = try await retryOnRateLimit { try await neighbourhoodService.neighbourhoods(inPoliceForce: policeForceID) }
        } catch let error as NeighbourhoodError {
            neighbourhoodError = error
        }

        #expect(neighbourhoodError == .notFound)
    }

    @Test("neighbourhood with ID in police force for City Centre Leicestershire")
    func neighbourhoodWithIDInPoliceForceForCityCentreLeicestershire() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"

        let neighbourhood = try await retry {
            try await neighbourhoodService.neighbourhood(
                withID: neighbourhoodID,
                inPoliceForce: policeForceID
            )
        }

        #expect(neighbourhood.id == neighbourhoodID)
    }

    @Test("neighbourhood with ID in police force for Caistor Lincolnshire")
    func neighbourhoodWithIDInPoliceForceForCaistorLincolnshire() async throws {
        let neighbourhoodID = "NC09"
        let policeForceID = "lincolnshire"

        let neighbourhood = try await retry {
            try await neighbourhoodService.neighbourhood(
                withID: neighbourhoodID,
                inPoliceForce: policeForceID
            )
        }

        #expect(neighbourhood.id == neighbourhoodID)
    }

    @Test("neighbourhood with ID in police force for invalid neighbourhood throws not found")
    func neighbourhoodWithIDInPoliceForceForInvalidNeighbourhood() async throws {
        let neighbourhoodID = "111"
        let policeForceID = "lincolnshire"

        var neighbourhoodError: NeighbourhoodError?
        do {
            _ = try await retryOnRateLimit { try await neighbourhoodService.neighbourhood(withID: neighbourhoodID, inPoliceForce: policeForceID) }
        } catch let error as NeighbourhoodError {
            neighbourhoodError = error
        }

        #expect(neighbourhoodError == .notFound)
    }

    @Test("neighbourhood with ID in police force for invalid police force throws not found")
    func neighbourhoodWithIDInPoliceForceForInvalidPoliceForce() async throws {
        let neighbourhoodID = "NC09"
        let policeForceID = "fff"

        var neighbourhoodError: NeighbourhoodError?
        do {
            _ = try await retryOnRateLimit { try await neighbourhoodService.neighbourhood(withID: neighbourhoodID, inPoliceForce: policeForceID) }
        } catch let error as NeighbourhoodError {
            neighbourhoodError = error
        }

        #expect(neighbourhoodError == .notFound)
    }

    @Test("neighbourhood at coordinate for Leeds City Centre")
    func neighbourhoodAtCoordinateForLeedsCityCentre() async throws {
        let leedsCityCentreCoordinate = CLLocationCoordinate2D(latitude: 53.797927, longitude: -1.541522)

        let neighbourhood = try await retry {
            try await neighbourhoodService.neighbourhood(at: leedsCityCentreCoordinate)
        }

        #expect(neighbourhood.id == "LDT_CITY")
        #expect(neighbourhood.name == "Leeds City")
    }

    @Test("neighbourhood at coordinate when coordinate is outside of data set region throws error")
    func neighbourhoodAtCoordinateWhenCoordinateIsOutsideOfDataSetRegion() async throws {
        let coordinate = CLLocationCoordinate2D(latitude: 10.11, longitude: 12.21)

        var neighbourhoodError: NeighbourhoodError?
        do {
            _ = try await retryOnRateLimit { try await neighbourhoodService.neighbourhood(at: coordinate) }
        } catch let error as NeighbourhoodError {
            neighbourhoodError = error
        }

        #expect(neighbourhoodError == .locationOutsideOfDataSetRegion)
    }

    @Test("boundary for neighbourhood in police force for Wakefield Central West Yorkshire")
    func boundaryForNeighbourhoodInPoliceForceForWakefieldCentralWestYorkshire() async throws {
        let neighbourhoodID = "WDT_CEN"
        let policeForceID = "west-yorkshire"

        let boundary = try await retry {
            try await neighbourhoodService.boundary(
                forNeighbourhood: neighbourhoodID,
                inPoliceForce: policeForceID
            )
        }

        #expect(boundary.count == 961)
    }

    @Test("police officers for neighbourhood in police force for Wakefield Central West Yorkshire")
    func policeOfficersForNeighbourhoodInPoliceForceForWakefieldCentralWestYorkshire() async throws {
        let neighbourhoodID = "WDT_CEN"
        let policeForceID = "west-yorkshire"

        let policeOfficers = try await retry {
            try await neighbourhoodService.policeOfficers(
                forNeighbourhood: neighbourhoodID,
                inPoliceForce: policeForceID
            )
        }

        #expect(!policeOfficers.isEmpty)
    }

    @Test("police officers for neighbourhood in police force for Doncaster West South Yorkshire")
    func policeOfficersForNeighbourhoodInPoliceForceForDoncasterWestSouthYorkshire() async throws {
        let neighbourhoodID = "AB"
        let policeForceID = "south-yorkshire"

        let policeOfficers = try await retry {
            try await neighbourhoodService.policeOfficers(
                forNeighbourhood: neighbourhoodID,
                inPoliceForce: policeForceID
            )
        }

        #expect(!policeOfficers.isEmpty)
    }

    @Test("priorities for neighbourhood in police force for Doncaster West South Yorkshire")
    func prioritiesForNeighbourhoodInPoliceForceForDoncasterWestSouthYorkshire() async throws {
        let neighbourhoodID = "AB"
        let policeForceID = "south-yorkshire"

        let priorities = try await retry {
            try await neighbourhoodService.priorities(
                forNeighbourhood: neighbourhoodID,
                inPoliceForce: policeForceID
            )
        }

        #expect(!priorities.isEmpty)
    }

    @Test("priorities for neighbourhood in police force for Gloucester City Centre Gloucestershire")
    func prioritiesForNeighbourhoodInPoliceForceForGloucesterCityCentreGloucestershire() async throws {
        let neighbourhoodID = "BA1"
        let policeForceID = "gloucestershire"

        let priorities = try await retry {
            try await neighbourhoodService.priorities(
                forNeighbourhood: neighbourhoodID,
                inPoliceForce: policeForceID
            )
        }

        #expect(!priorities.isEmpty)
    }

    @Test("neighbourhood policing team at coordinate for Gloucester City Centre Gloucestershire")
    func neighbourhoodPolicingTeamAtCoordinateForGloucesterCityCentreGloucestershire() async throws {
        let gloucesterCoordinate = CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.2413)

        let policingTeam = try await retry {
            try await neighbourhoodService.neighbourhoodPolicingTeam(at: gloucesterCoordinate)
        }

        #expect(policingTeam.force == "gloucestershire")
        #expect(policingTeam.neighbourhood == "BA1")
    }

    @Test("events for neighbourhood in police force")
    func eventsForNeighbourhoodInPoliceForce() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"

        let events = try await retry {
            try await neighbourhoodService.events(
                forNeighbourhood: neighbourhoodID,
                inPoliceForce: policeForceID
            )
        }

        _ = events
    }

}
