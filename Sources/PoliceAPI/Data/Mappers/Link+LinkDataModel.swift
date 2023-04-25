import Foundation

extension Link {

    init(dataModel: LinkDataModel) {
        self.init(
            title: dataModel.title,
            description: dataModel.description,
            url: dataModel.url
        )
    }

}
