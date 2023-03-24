import Foundation

struct Discount: Codable {
    var id = UUID()
    let name: String
    let expiryDate: String
    let image: String
    
    static let dummyData: [Discount] = [
        Discount.init(name: "10 % discount for the first order",
                      expiryDate: "31.03.2023",
                      image: "10.circle"),
        Discount.init(name: "15 % discount for the second order",
                      expiryDate: "31.03.2023",
                      image: "15.circle"),
        Discount.init(name: "20 % discount for second product in order",
                      expiryDate: "31.01.2023",
                      image: "20.circle"),
        Discount.init(name: "25 % discount for third product in order",
                      expiryDate: "30.04.2023",
                      image: "25.circle"),
        Discount.init(name: "35 % discount for fourth product in order",
                      expiryDate: "30.06.2023",
                      image: "35.circle"),
        Discount.init(name: "50 % discount for fifth product in order",
                      expiryDate: "31.08.2023",
                      image: "50.circle"),
    ]
}
