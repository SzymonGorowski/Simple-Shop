import Foundation

struct Category: Codable {
    let id: Int
    let name: String
    let image: String
    let creationAt: String
    let updatedAt: String
    
    static let mock: Category = Category(id: 1,
                                         name: "Furniture",
                                         image: "https://api.lorem.space/image/watch?w=640&h=480&r=8533",
                                         creationAt: "",
                                         updatedAt: "")
}
