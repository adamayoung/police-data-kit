import Foundation
import UKPoliceData

extension Neighbourhood {

    static var mock: Neighbourhood {
        Neighbourhood(
            id: "NC04",
            name: "City Centre",
            description: "<p>The Castle neighbourhood is a diverse covering all of the City Centre. In addition it "
                + "covers De Montfort University, the University of Leicester, Leicester Royal Infirmary, the "
                + "Leicester Tigers rugby ground and the Clarendon Park and Riverside communities.</p>\n<p>The "
                + "Highcross and Haymarket shopping centres and Leicester's famous Market are all covered by this "
                + "neighbourhood.</p>",
            policeForceWebsite: URL(string: "http://www.leics.police.uk/local-policing/city-centre")!,
            population: 1000,
            contactDetails: ContactDetails(
                email: "centralleicester.npa@leicestershire.pnn.police.uk",
                telephone: "101",
                facebook: URL(string: "http://www.facebook.com/leicspolice")!,
                twitter: URL(string: "http://www.twitter.com/centralleicsNPA")!
            ),
            centre: Coordinate(
                latitude: 52.6389,
                longitude: -1.13619
            ),
            locations: [
                NeighbourhoodLocation(
                    name: "Mansfield House",
                    type: "station",
                    address: "74 Belgrave Gate\n, Leicester",
                    postcode: "LE1 3GG"
                )
            ],
            links: [
                Link(
                    title: "Leicester City Council",
                    url: URL(string: "http://www.leicester.gov.uk/")!
                )
            ]
        )
    }

}
