import UIKit

final class ProductDetailViewViewModel: NSObject {
    let product: Product
    
    private var cellViewModels: [ProductImagesCollectionViewCellViewModel] = []
    
    private var images: [String] = [] {
        didSet {
            for image in product.images {
                let viewModel = ProductImagesCollectionViewCellViewModel(image: image)
                cellViewModels.append(viewModel)
            }
        }
    }
    
    // MARK: - Init
    init(product: Product) {
        self.product = product
    }
    
    @objc func addToCartButtonTapped(sender: UIButton) {
        Cart.shared.addItem(product)
    }
}

// MARK: Extensions
extension ProductDetailViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductImagesCollectionViewCell.identifier,
                                                            for: indexPath) as? ProductImagesCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: product.images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = bounds.width - 50
        let height = width * 0.5
        return CGSize(width: width, height: height)
    }
}
