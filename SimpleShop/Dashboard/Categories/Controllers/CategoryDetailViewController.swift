import UIKit

final class CategoryDetailViewController: UIViewController {
    private let viewModel: CategoryDetailViewViewModel
    private let categoryDetailView: CategoryDetailView
    
    // MARK: - Init
    init(viewModel: CategoryDetailViewViewModel) {
        self.viewModel = viewModel
        categoryDetailView = CategoryDetailView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        categoryDetailView.delegate = self
    }

    // MARK: - Set Up View
    private func setUpView() {
        view.backgroundColor = .systemBackground
        title = viewModel.title
        addView(categoryDetailView)
    }
}

// MARK: Extension
extension CategoryDetailViewController: CategoryDetailViewDelegate {
    func categoryDetailView(_ categoryDetailView: CategoryDetailView, didSelectProduct product: Product) {
        let detailVC = ProductDetailViewController(viewModel: ProductDetailViewViewModel(product: product))
        pushViewController(detailVC)
    }
}
