import UIKit

final class UserDetailsViewController: UIViewController {
    private let userView = UserDetailsView()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        userView.delegate = self
    }
    
    // MARK: - Set Up View
    private func setUpView() {
        view.backgroundColor = .systemBackground
        title = Strings.UserDetailsView.navigationTitle

        addView(userView)
    }
}

// MARK: Extension
extension UserDetailsViewController: UserDetailsViewDelegate {
    func userDetailsView(_ userDetails: UserDetailsView, didTapContinue customer: Customer) {
        let viewModel = ConfirmOrderViewViewModel(customer: customer)
        let vc = ConfirmOrderViewController(viewModel: viewModel)
        pushViewController(vc)
    }
}
