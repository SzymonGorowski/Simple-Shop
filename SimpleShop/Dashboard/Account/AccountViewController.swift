import UIKit

final class AccountViewController: UIViewController {
    private let accountView = AccountView()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        accountView.delegate = self
    }
    
    // MARK: - Set Up View
    private func setUpView() { 
        view.backgroundColor = .systemBackground
        title = Strings.DashboardTabView.AccountTab.navigationTitle
        navigationItem.largeTitleDisplayMode = .automatic

        addView(accountView)
    }
}

// MARK: Extension
extension AccountViewController: AccountViewDelegate {
    func accountView(_ accountView: AccountView, didSelectSection section: AccountSection) {
        var detailVC: UIViewController
        switch section.type {
        case .personalDetails:
            detailVC = PersonalDetailsViewController(title: section.name)
        case .orders:
            detailVC = OrdersViewController(title: section.name)
        case .privacyPolicy, .contact, .info, .notifications, .settings:
            detailVC = AccountDetailViewController(title: section.name)
        }
        pushViewController(detailVC)
    }
}
