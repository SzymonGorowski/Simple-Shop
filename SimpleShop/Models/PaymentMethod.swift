import Foundation

enum PaymentMethod {
    case cash
    case bankTransfer
    case blik
    
    var displayTitle: String {
        switch self {
        case .cash:
            return Strings.PaymentMethod.Cash.title
        case .bankTransfer:
            return Strings.PaymentMethod.BankTransfer.title
        case .blik:
            return Strings.PaymentMethod.Blik.title
        }
    }
    
    var tag: Int {
        switch self {
        case .cash:
            return 1
        case .bankTransfer:
            return 2
        case .blik:
            return 3
        }
    }
}
