import Foundation

struct Order {
    let id = UUID()
    let totalAmount: Int
    let items: [CartItem]
    let customer: Customer?
    let paymentMethod: PaymentMethod
    let deliveryMethod: DeliveryMethod
    let orderDate: Date
    let deliveryDate: Date
    let orderStatus: OrderStatus
}

enum OrderStatus {
    case pending
    case inDelivery
    case delivered
    case canceled
}
