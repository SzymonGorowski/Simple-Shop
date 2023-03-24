import UIKit

final class ProductDetailViewController: UIViewController {
    private let productDetailView: ProductDetailView
    private let viewModel: ProductDetailViewViewModel
    
    // MARK: - Init
    init(viewModel: ProductDetailViewViewModel) {
        self.viewModel = viewModel
        productDetailView = ProductDetailView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    // MARK: - Set Up View
    private func setUpView() {
        view.backgroundColor = .systemBackground
        addView(productDetailView)
    }
}
