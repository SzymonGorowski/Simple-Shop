import UIKit

protocol CategoryDetailViewViewModelDelegate: AnyObject {
    func didLoadProducts()
    func didSelectProduct(_ product: Product)
}

final class CategoryDetailViewViewModel: NSObject {
    private let category: Category
    private var cellViewModels: [ProductCollectionViewCellViewModel] = []
    
    weak var delegate: CategoryDetailViewViewModelDelegate?
    
    private var products: [Product] = [] {
        didSet {
            for product in products {
                if let imageString = product.images.first {
                    let viewModel = ProductCollectionViewCellViewModel(name: product.title,
                                                                       imageURL: URL(string: imageString),
                                                                       price: product.price)
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    var title: String {
        category.name.uppercased()
    }
    
    // MARK: - Init
    init(category: Category) {
        self.category = category
    }
    
    func fetchProducts() {
        let request = NetworkRequest(endpoint: .products, queryParameters: [URLQueryItem(name: "categoryId", value: "\(category.id)")])
        NetworkService.shared.execute(request, expecting: [Product].self) { result in
            switch result {
            case .success(let products):
                self.products = products
                DispatchQueue.main.async {
                    self.delegate?.didLoadProducts()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}


// MARK: Extensions
extension CategoryDetailViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier,
                                                            for: indexPath) as? ProductCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = bounds.width - 30
        let height = width * 0.5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let product = products[indexPath.row]
        delegate?.didSelectProduct(product)
    }
}
