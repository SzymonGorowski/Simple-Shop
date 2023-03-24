import UIKit

final class ConfirmOrderViewViewModel: NSObject {
    @Published var selectedPaymentMethod: PaymentMethod = .cash
    @Published var selectedDeliveryMethod: DeliveryMethod = .personalCollection
    let customer: Customer
    
    // MARK: Init
    init(customer: Customer) {
        self.customer = customer
    }
    
    func addBorderToButton(_ button: UIButton) {
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.systemGreen.cgColor
    }

    func removeBorderFromButtons(_ buttons: [UIButton]) {
        buttons.forEach { button in
            button.layer.borderWidth = 0
            button.layer.borderColor = UIColor.clear.cgColor
        }
    }
}

// MARK: - Extensions
extension ConfirmOrderViewViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cart.shared.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderedProductTableViewCell.identifier, for: indexPath) as? OrderedProductTableViewCell else { fatalError() }
        let cartItem = Cart.shared.items[indexPath.row]
        cell.configure(with: cartItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        return Strings.ConfirmOrderView.TableView.header
    }
}
