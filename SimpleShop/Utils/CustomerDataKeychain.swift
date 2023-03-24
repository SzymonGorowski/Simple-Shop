import Foundation

struct CustomerDataKeychain: KeychainStorage {
    var account = "com.simpleShop.customerData"
    var service = "customerData"
    
    typealias DataType = Customer
}
