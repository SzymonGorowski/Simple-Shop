import Foundation

struct Customer: Codable {
    var id = UUID()
    let name: String
    let email: String
    let address: String
    let phoneNumber: String
}
