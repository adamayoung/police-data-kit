import Foundation

extension Neighbourhood {

    init(dataModel: NeighbourhoodDataModel) {
        let contactDetails = ContactDetails(dataModel: dataModel.contactDetails)
        let centre = Coordinate(dataModel: dataModel.centre)
        let locations = dataModel.locations.map(NeighbourhoodLocation.init)
        let links = dataModel.links.map(Link.init)

        self.init(
            id: dataModel.id,
            name: dataModel.name,
            description: dataModel.description,
            policeForceWebsiteURL: dataModel.policeForceWebsite,
            welcomeMessage: dataModel.welcomeMessage,
            population: dataModel.population,
            contactDetails: contactDetails,
            centre: centre,
            locations: locations,
            links: links
        )
    }

}
