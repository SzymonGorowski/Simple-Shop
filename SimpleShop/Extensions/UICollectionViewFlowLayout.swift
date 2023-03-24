import UIKit

extension UICollectionViewFlowLayout {
    func setupCollectionViewLayout() {
        self.scrollDirection = .vertical
        self.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 10)
    }
}
