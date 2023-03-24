import UIKit

extension UITextField {
    func setupRoundedTextField(placeholderText: String) {
        self.placeholder = placeholderText
        self.borderStyle = .roundedRect
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
