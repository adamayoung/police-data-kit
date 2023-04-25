import Foundation
import PoliceAPIDomain

extension ContactDetails {

    init(dataModel: ContactDetailsDataModel) {
        self.init(
            email: dataModel.email,
            telephone: dataModel.telephone,
            mobile: dataModel.mobile,
            fax: dataModel.fax,
            web: dataModel.web,
            address: dataModel.address,
            facebook: dataModel.facebook,
            twitter: dataModel.twitter,
            youtube: dataModel.youtube,
            myspace: dataModel.myspace,
            bebo: dataModel.bebo,
            flickr: dataModel.flickr,
            forum: dataModel.forum,
            blog: dataModel.blog,
            rss: dataModel.rss
        )
    }

}
