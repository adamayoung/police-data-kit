import Foundation

///
/// A category of a crime.
///
public enum CrimeCategory: Equatable {

    /// Default crime category.
    public static let `default` = Self.allCrime

    /// All crime.
    case allCrime

    /// Anti-social behaviour.
    case antiSocialBehaviour

    /// Bicycle theft.
    case bicycleTheft

    /// Burglary.
    case burglary

    /// Criminal damage or arson.
    case criminalDamageArson

    /// Drugs.
    case drugs

    /// Other theft.
    case otherTheft

    /// Possession of weapons.
    case possessionOfWeapons

    /// Public order.
    case publicOrder

    /// Robbery.
    case robbery

    /// Shoplifting.
    case shoplifting

    /// Theft from the person.
    case theftFromThePerson

    /// Vehcile crime.
    case vehicleCrime

    /// Violent crime.
    case violentCrime

    /// Other crime.
    case otherCrime

    /// A localized name describing the crime category.
    public var localizedName: String {
        switch self {
        case .allCrime:
            return NSLocalizedString("CRIME_CATEGORY_ALL_CRIME", bundle: .module,
                                     comment: "All crime crime category label")

        case .antiSocialBehaviour:
            return NSLocalizedString("CRIME_CATEGORY_ANTI_SOCIAL_BEHAVIOUR", bundle: .module,
                                     comment: "Anti-social behaviour crime category label")

        case .bicycleTheft:
            return NSLocalizedString("CRIME_CATEGORY_BICYCLE_THEFT", bundle: .module,
                                     comment: "Bicycle theft crime category label")

        case .burglary:
            return NSLocalizedString("CRIME_CATEGORY_BURGLARY", bundle: .module,
                                     comment: "Burglary crime category label")

        case .criminalDamageArson:
            return NSLocalizedString("CRIME_CATEGORY_CRIMINAL_DAMAGE_AND_ARSON", bundle: .module,
                                     comment: "Criminal damage and arson crime category label")

        case .drugs:
            return NSLocalizedString("CRIME_CATEGORY_DRUGS", bundle: .module, comment: "Drugs crime category label")

        case .otherTheft:
            return NSLocalizedString("CRIME_CATEGORY_OTHER_THEFT", bundle: .module,
                                     comment: "Other theft crime category label")

        case .possessionOfWeapons:
            return NSLocalizedString("CRIME_CATEGORY_POSSESSION_OF_WEAPONS", bundle: .module,
                                     comment: "Possession of weapons crime category label")

        case .publicOrder:
            return NSLocalizedString("CRIME_CATEGORY_PUBLIC_ORDER", bundle: .module,
                                     comment: "Public order crime category label")

        case .robbery:
            return NSLocalizedString("CRIME_CATEGORY_ROBBERY", bundle: .module,
                                     comment: "Robbery crime category label")

        case .shoplifting:
            return NSLocalizedString("CRIME_CATEGORY_SHOPLIFTING", bundle: .module,
                                     comment: "Shoplifting crime category label")

        case .theftFromThePerson:
            return NSLocalizedString("CRIME_CATEGORY_THEFT_FROM_THE_PERSON", bundle: .module,
                                     comment: "Theft from the person crime category label")

        case .vehicleCrime:
            return NSLocalizedString("CRIME_CATEGORY_VEHICLE_CRIME", bundle: .module,
                                     comment: "Vehicle crime crime category label")

        case .violentCrime:
            return NSLocalizedString("CRIME_CATEGORY_VIOLENCE_OR_SEXUAL_OFFENCE", bundle: .module,
                                     comment: "Violence or sexual offence crime category label")

        case .otherCrime:
            return NSLocalizedString("CRIME_CATEGORY_OTHER_CRIME", bundle: .module,
                                     comment: "Other crime crime category label")
        }
    }

}
