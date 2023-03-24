import UIKit

final class CategoriesViewController: UIViewController {
    private let categoriesListView = CategoriesListView()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesListView.delegate = self
        setUpView()
    }
    
    // MARK: - Set Up View
    private func setUpView() {
        view.backgroundColor = .systemBackground
        title = Strings.DashboardTabView.CategoryTab.navigationTitle
        navigationItem.largeTitleDisplayMode = .automatic
        addView(categoriesListView)
    }
}

// MARK: Extension
extension CategoriesViewController: CategoriesListViewDelegate {
    func categoryListView(_ categoryListView: CategoriesListView, didSelectCategory category: Category) {
        let detailVC = CategoryDetailViewController(viewModel: CategoryDetailViewViewModel(category: category))
        pushViewController(detailVC)
    }
}
