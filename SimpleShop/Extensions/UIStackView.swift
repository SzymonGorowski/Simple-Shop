import UIKit

extension UIStackView {
    func setupStackView(
        axis: NSLayoutConstraint.Axis,
        alignment: UIStackView.Alignment,
        spacing: CGFloat
        
    ) {
        self.axis = axis
        self.alignment = alignment
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
