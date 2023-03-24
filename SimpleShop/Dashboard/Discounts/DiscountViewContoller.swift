import UIKit

final class DiscountViewController: UIViewController {
    private let discountListView = DiscountListView()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    
    // MARK: - Set Up View
    private func setUpView() {
        view.backgroundColor = .systemBackground
        title = Strings.DashboardTabView.DiscountsTab.navigationTitle
        navigationItem.largeTitleDisplayMode = .automatic

        addView(discountListView)
    }
}
