import Foundation
import Combine

final class Cart {
    static let shared = Cart()
    
    private init() { }
    
    @Published var items: [CartItem] = []
    @Published var total = 0
    
    func addItem(_ product: Product) {
        if contains(product) {
            if let itemIndex = findIndex(for: product) {
                items[itemIndex].quantity += 1
            }
        } else {
            let cartItem = CartItem(from: product)
            items.append(cartItem)
        }
        
        recalculateTotal()
    }
    
    func removeItem(_ product: Product) {
        if let itemIndex = findIndex(for: product) {
            if items[itemIndex].quantity == 1 {
                items.remove(at: itemIndex)
            } else {
                items[itemIndex].quantity -= 1
            }
        }
        
        recalculateTotal()
    }
    
    func deleteItem(_ product: Product) {
        if let itemIndex = findIndex(for: product) {
            items.remove(at: itemIndex)
        }
        
        recalculateTotal()
    }
    
    private func recalculateTotal() {
        total = items.compactMap { $0.totalPrice }.reduce(0) { $0 + $1 }
    }

    private func contains(_ product: Product) -> Bool {
        items.firstIndex { $0.product.id == product.id } != nil
    }
    
    private func findIndex(for item: Product) -> Int? {
        items.firstIndex { $0.product.id == item.id }
    }
}
