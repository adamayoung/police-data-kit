import Foundation

extension Link {

    init(dataModel: LinkDataModel) {
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
