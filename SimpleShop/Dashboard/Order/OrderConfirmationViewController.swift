import UIKit

final class OrderConfirmationViewController: UIViewController {
    private let orderConfirmationView = OrderConfirmationView()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    // MARK: - Set Up View
    private func setUpView() {
        view.backgroundColor = .systemBackground
        title = Strings.OrderConfirmationViewController.navigationTitle
        orderConfirmationView.delegate = self
        
        addView(orderConfirmationView)
    }
}

extension OrderConfirmationViewController: OrderConfirmationViewDelegate {
    func orderConfirmationView(_ orderConfirmationView: OrderConfirmationView) {
        self.navigationController?.popToRootViewController(animated: true)
        Cart.shared.items.removeAll()
        Cart.shared.total = 0
    }
}
