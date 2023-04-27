import Foundation

extension CrimeCategory {

    var id: CrimeCategoryDataModel.ID {
        switch self {
        case .allCrime:
            return "all-crime"

        case .antiSocialBehaviour:
            return "anti-social-behaviour"

        case .bicycleTheft:
            return "bicycle-theft"

        case .burglary:
            return "burglary"

        case .criminalDamageArson:
            return "criminal-damage-arson"

        case .drugs:
            return "drugs"

        case .otherTheft:
            return "other-theft"

        case .possessionOfWeapons:
            return "possession-of-weapons"

        case .publicOrder:
            return "public-order"

        case .robbery:
            return "robbery"

        case .shoplifting:
            return "shoplifting"

        case .theftFromThePerson:
            return "theft-from-the-person"

        case .vehicleCrime:
            return "vehicle-crime"

        case .violentCrime:
            return "violent-crime"

        case .otherCrime:
            return "other-crime"
        }
    }

}
