import Foundation

final class CartItem: Identifiable {
    let id = UUID()
    let product: Product
    @Published var quantity: Int = 1
    
    var totalPrice: Int {
        product.price * quantity
    }
    
    init(from product: Product) {
        self.product = product
    }
    
    static let mock: CartItem = CartItem(from: Product.mock)
}
