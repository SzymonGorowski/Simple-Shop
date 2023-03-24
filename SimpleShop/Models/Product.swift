import Foundation

struct Product: Codable {
    let id: Int
    let title: String
    let price: Int
    let description: String
    let category: Category
    let images: [String]
    
    static let mock: Product = Product(id: 1,
                                       title: "Sport Shoes",
                                       price: 100,
                                       description: "Brand new shoes",
                                       category: Category.mock,
                                       images: ["https://api.lorem.space/image/watch?w=640&h=480&r=8533"])
}
