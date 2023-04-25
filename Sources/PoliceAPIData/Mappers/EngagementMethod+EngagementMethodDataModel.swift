import Foundation
import PoliceAPIDomain

extension EngagementMethod {

    init(dataModel: EngagementMethodDataModel) {
        self.init(
            title: dataModel.title,
            description: dataModel.description,
            url: dataModel.url
        )
    }

}
