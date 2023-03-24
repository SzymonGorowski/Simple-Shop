import UIKit

extension UIImageView {
    func setupImageView(contentMode: UIView.ContentMode) {
        self.contentMode = contentMode
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
