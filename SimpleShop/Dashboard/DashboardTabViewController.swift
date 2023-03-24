import UIKit
import Combine

final class DashboardTabViewController: UITabBarController {
    private var bindings = Set<AnyCancellable>()
    private var quantity = 0
    
    private let nav1 = UINavigationController(rootViewController: CategoriesViewController())
    private let nav2 = UINavigationController(rootViewController: CartViewController())
    private let nav3 = UINavigationController(rootViewController: DiscountViewController())
    private let nav4 = UINavigationController(rootViewController: AccountViewController())

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
        setupBinding()
    }

    // MARK: - Set Up Tabs
    private func setUpTabs() {
        nav1.tabBarItem = UITabBarItem(title: Strings.DashboardTabView.CategoryTab.navigationTitle,
                                       image: UIImage.systemBasketImage,
                                       tag: 1)
        nav2.tabBarItem = UITabBarItem(title: Strings.DashboardTabView.CartTab.navigationTitle,
                                       image: UIImage.systemCartImage,
                                       tag: 2)
        nav3.tabBarItem = UITabBarItem(title: Strings.DashboardTabView.DiscountsTab.navigationTitle,
                                       image: UIImage.systemExclamationMarkImage,
                                       tag: 3)
        nav4.tabBarItem = UITabBarItem(title: Strings.DashboardTabView.AccountTab.navigationTitle,
                                       image: UIImage.systemPersonImage,
                                       tag: 4)
        
        for nav in [nav1, nav2, nav3, nav4] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
    }
    
    // MARK: - Private
    private func setupBinding() {
        Cart.shared.$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updateBadge()
            }
            .store(in: &bindings)
    }
    
    private func updateBadge() {
        quantity = Cart.shared.items.count
        nav2.tabBarItem.badgeValue = "\(quantity)"
    }
}
