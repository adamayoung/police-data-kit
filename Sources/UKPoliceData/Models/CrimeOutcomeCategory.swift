// import Foundation
//
// /// Category of the outcome of a crime.
// public enum CrimeOutcomeCategory: String, Decodable, CaseIterable {
//
//    /// Awaiting court outcome.
//    case awaitingCourtResult = "awaiting-court-result"
//    /// Court result unavailable.
//    case courtResultUnavailable = "court-result-unavailable"
//    /// Court case unable to proceed.
//    case unableToProceed = "unable-to-proceed"
//    /// Local resolution.
//    case localResolution = "local-resolution"
//    /// Investigation complete; no suspect identified.
//    case noFurtherAction = "no-further-action"
//    /// Offender deprived of property.
//    case deprivedOfProperty = "deprived-of-property"
//    /// Offender fined.
//    case fined
//    /// Offender given absolute discharge.
//    case absoluteDischarge = "absolute-discharge"
//    /// Offender given a caution.
//    case cautioned
//    /// Offender given a drugs possession warning.
//    case drugsPossessionWarning = "drugs-possession-warning"
//    /// Offender given a penalty notice.
//    case penaltyNoticeIssued = "penalty-notice-issued"
//    /// Offender given a penalty notice.
//    case communityPenalty = "community-penalty"
//    /// Offender given conditional discharge.
//    case conditionalDischarge = "conditional-discharge"
//    /// Offender given suspended prison sentence.
//    case suspendedSentence = "suspended-sentence"
//    /// Offender sent to prison.
//    case imprisoned
//    /// Offender otherwise dealt with.
//    case otherCourtDisposal = "other-court-disposal"
//    /// Offender ordered to pay compensation.
//    case compensation
//    /// Suspect charged as part of another case.
//    case sentencedInAnotherCase = "sentenced-in-another-case"
//    /// Suspect charged.
//    case charged
//    /// Defendant found not guilty.
//    case notGuilty = "not-guilty"
//    /// Defendant sent to Crown Court.
//    case sentToCrownCourt = "sent-to-crown-court"
//    /// Unable to prosecute suspect
//    case unableToProsecute = "unable-to-prosecute"
//    /// Formal action is not in the public interest.
//    case formalActionNotInPublicInterest = "formal-action-not-in-public-interest"
//    /// Action to be taken by another organisation.
//    case actionTakenByAnotherOrganisation = "action-taken-by-another-organisation"
//    /// Further investigation is not in the public interest.
//    case furtherInvestigationNotInPublicInterest = "further-investigation-not-in-public-interest"
//    /// Further action is not in the public interest.
//    case furtherActionNotInPublicInterest = "further-action-not-in-public-interest"
//    /// Under investigation.
//    case underInvestigation = "under-investigation"
//    /// Status update unavailable.
//    case statusUpdateUnavailable = "status-update-unavailable"
//
// }
//
// extension CrimeOutcomeCategory: CustomStringConvertible {
//
//    public var description: String {
//        switch self {
//        case .awaitingCourtResult:
//            return "Awaiting court outcome"
//
//        case .courtResultUnavailable:
//            return "Court result unavailable"
//
//        case .unableToProceed:
//            return "Court case unable to proceed"
//
//        case .localResolution:
//            return "Local resolution"
//
//        case .noFurtherAction:
//            return "Investigation complete; no suspect identified"
//
//        case .deprivedOfProperty:
//            return "Offender deprived of property"
//
//        case .fined:
//            return "Offender fined"
//
//        case .absoluteDischarge:
//            return "Offender given absolute discharge"
//
//        case .cautioned:
//            return "Offender given a caution"
//
//        case .drugsPossessionWarning:
//            return "Offender given a drugs possession warning"
//
//        case .penaltyNoticeIssued:
//            return "Offender given a penalty notice"
//
//        case .communityPenalty:
//            return "Offender given community sentence"
//
//        case .conditionalDischarge:
//            return "Offender given conditional discharge"
//
//        case .suspendedSentence:
//            return "Offender given suspended prison sentence"
//
//        case .imprisoned:
//            return "Offender sent to prison"
//
//        case .otherCourtDisposal:
//            return "Offender otherwise dealt with"
//
//        case .compensation:
//            return "Offender ordered to pay compensation"
//
//        case .sentencedInAnotherCase:
//            return "Suspect charged as part of another case"
//
//        case .charged:
//            return "Suspect charged"
//
//        case .notGuilty:
//            return "Defendant found not guilty"
//
//        case .sentToCrownCourt:
//            return "Defendant sent to Crown Court"
//
//        case .unableToProsecute:
//            return "Unable to prosecute suspect"
//
//        case .formalActionNotInPublicInterest:
//            return "Formal action is not in the public interest"
//
//        case .actionTakenByAnotherOrganisation:
//            return "Action to be taken by another organisation"
//
//        case .furtherInvestigationNotInPublicInterest:
//            return "Further investigation is not in the public interest"
//
//        case .furtherActionNotInPublicInterest:
//            return "Further action is not in the public interest"
//
//        case .underInvestigation:
//            return "Under investigation"
//
//        case .statusUpdateUnavailable:
//            return "Status update unavailable"
//        }
//    }
//
// }
