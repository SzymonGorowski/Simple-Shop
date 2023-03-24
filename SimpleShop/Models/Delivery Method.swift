import Foundation

enum DeliveryMethod {
    case personalCollection
    case fastDelivery
    case standardDelivery
    
    var displayTitle: String {
        switch self {
        case .personalCollection:
            return Strings.DeliveryMethod.PersonalCollection.title
        case .fastDelivery:
            return Strings.DeliveryMethod.FastDelivery.title
        case .standardDelivery:
            return Strings.DeliveryMethod.StandardDelivery.title
        }
    }
    
    var tag: Int {
        switch self {
        case .personalCollection:
            return 1
        case .fastDelivery:
            return 2
        case .standardDelivery:
            return 3
        }
    }
}

