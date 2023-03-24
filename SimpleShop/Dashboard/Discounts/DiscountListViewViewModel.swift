import UIKit

final class DiscountListViewViewModel: NSObject {
    private let discounts: [Discount] = Discount.dummyData
}

// MARK: Extensions
extension DiscountListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discounts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscountCollectionViewCell.identifier,
                                                            for: indexPath) as? DiscountCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        let discount = discounts[indexPath.row]
        cell.configure(with: discount)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = bounds.width - 30
        let height = width * 0.5
        return CGSize(width: width, height: height)
    }
}
