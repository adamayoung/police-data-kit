import CoreLocation
import Foundation

extension Neighbourhood {

    init(dataModel: NeighbourhoodDataModel) {
        let policeForceWebsiteURL: URL? = {
            guard let website = dataModel.policeForceWebsite else {
                return nil
            }

            return URL(string: website)
        }()
        let population: Int? = {

            guard let population = Int(dataModel.population), population > 0 else {
                return nil
            }

            return population
        }()
        let contactDetails = ContactDetails(dataModel: dataModel.contactDetails)
        let centre = CLLocationCoordinate2D(dataModel: dataModel.centre)
        let locations = dataModel.locations.map(NeighbourhoodLocation.init)
        let links = dataModel.links.map(Link.init)

        self.init(
            id: dataModel.id,
            name: dataModel.name.htmlStripped,
            description: dataModel.description?.htmlStripped,
            policeForceWebsiteURL: policeForceWebsiteURL,
            welcomeMessage: dataModel.welcomeMessage,
            population: population,
            contactDetails: contactDetails,
            centre: centre,
            locations: locations,
            links: links
        )
    }

}
