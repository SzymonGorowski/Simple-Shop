import UIKit

final class ConfirmOrderViewController: UIViewController {
    private let confirmOrderView: ConfirmOrderView
    private let viewModel: ConfirmOrderViewViewModel
    
    // MARK: - Init
    init(viewModel: ConfirmOrderViewViewModel) {
        self.viewModel = viewModel
        confirmOrderView = ConfirmOrderView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        confirmOrderView.viewDelegate = self
    }
    
    // MARK: - Set Up View
    private func setUpView() {
        view.backgroundColor = .systemBackground
        title = Strings.ConfirmOrderViewController.navigationTitle

        addView(confirmOrderView)
    }
}

extension ConfirmOrderViewController: ConfirmOrderViewDelegate {
    func confirmOrderView(_ confirmView: ConfirmOrderView) {
        let vc = OrderConfirmationViewController()
        pushViewController(vc)
    }
}
