import UIKit

extension UICollectionViewCell {
    func setUpLayer(
        shadowOffset: CGSize
    ) {
        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.shadowColor = UIColor.label.cgColor
        self.contentView.layer.shadowRadius = 4
        self.contentView.layer.shadowOffset = shadowOffset
        self.contentView.layer.shadowOpacity = 0.3
    }
}
