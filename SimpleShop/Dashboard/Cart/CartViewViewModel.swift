import UIKit

final class CartViewViewModel: NSObject { }

//MARK: Extensions
extension CartViewViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Cart.shared.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartItemCollectionViewCell.identifier, for: indexPath) as? CartItemCollectionViewCell else {
            fatalError("Unsupported")
        }
        let cartItem = Cart.shared.items[indexPath.row]
        cell.configure(with: cartItem, at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = bounds.width - 30
        let height = width * 0.40
        return CGSize(width: width, height: height)
    }
}
