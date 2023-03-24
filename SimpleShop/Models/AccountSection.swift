import UIKit

struct AccountSection {
    enum AccountSectionType {
        case personalDetails
        case orders
        case settings
        case notifications
        case info
        case contact
        case privacyPolicy
    }
    
    var id = UUID()
    let name: String
    let systemImage: String
    let type: AccountSectionType
    
    static let dummyData: [AccountSection] = [
        .init(name: "Personal Details", systemImage: "person.crop.circle", type: .personalDetails),
        .init(name: "Orders", systemImage: "bag.circle", type: .orders),
        .init(name: "Settings", systemImage: "gear.circle", type: .settings),
        .init(name: "Notification", systemImage: "phone.circle", type: .notifications),
        .init(name: "Info", systemImage: "info.circle", type: .info),
        .init(name: "Contact", systemImage: "person.2.circle", type: .contact),
        .init(name: "Privacy Policy", systemImage: "book.circle", type: .privacyPolicy),
        ]
}
