import Foundation

extension EngagementMethod {

    init(dataModel: EngagementMethodDataModel) {
        let url: URL? = {
            guard let urlString = dataModel.url else {
                return nil
            }

            return URL(string: urlString)
        }()

        self.init(
            title: dataModel.title,
            description: dataModel.description,
            url: url
        )
    }

}
