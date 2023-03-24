import UIKit
import Combine

final class CartViewController: UIViewController {
    private let cartView = CartView()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        cartView.delegate = self
        setUpView()
    }

    // MARK: - Set Up View
    private func setUpView() {
        view.backgroundColor = .systemBackground
        title = Strings.DashboardTabView.CartTab.navigationTitle
        navigationItem.largeTitleDisplayMode = .automatic

        addView(cartView)
    }
}

extension CartViewController: CartViewDelegate {
    func cartView(_ cartView: CartView) {
        let detailVC = UserDetailsViewController()
        pushViewController(detailVC)
    }
}
