import Foundation

extension PoliceForce {

    init(dataModel: PoliceForceDataModel) {
        let engagementMethods = dataModel.engagementMethods.map(EngagementMethod.init)

        self.init(
            id: dataModel.id,
            name: dataModel.name,
            description: dataModel.description,
            telephone: dataModel.telephone,
            url: dataModel.url,
            engagementMethods: engagementMethods
        )
    }

}
