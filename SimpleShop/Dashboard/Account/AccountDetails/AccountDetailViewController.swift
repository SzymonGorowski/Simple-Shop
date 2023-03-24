import UIKit

final class AccountDetailViewController: UIViewController {
    let navigationTitle: String
    
    // MARK: Init
    init(title: String) {
        self.navigationTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = navigationTitle
    }
}
