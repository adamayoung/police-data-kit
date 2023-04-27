import Foundation

extension CrimeCategory {

    init(dataModel: CrimeCategoryDataModel) {
        switch dataModel.id {
        case "all-crime":
            self = .allCrime

        case "anti-social-behaviour":
            self = .antiSocialBehaviour

        case "bicycle-theft":
            self = .bicycleTheft

        case "burglary":
            self = .burglary

        case "criminal-damage-arson":
            self = .criminalDamageArson

        case "drugs":
            self = .drugs

        case "other-theft":
            self = .otherTheft

        case "possession-of-weapons":
            self = .possessionOfWeapons

        case "public-order":
            self = .publicOrder

        case "robbery":
            self = .robbery

        case "shoplifting":
            self = .shoplifting

        case "theft-from-the-person":
            self = .theftFromThePerson

        case "vehicle-crime":
            self = .vehicleCrime

        case "violent-crime":
            self = .violentCrime

        case "other-crime":
            self = .otherCrime

        default:
            self = .otherCrime
        }
    }

}
