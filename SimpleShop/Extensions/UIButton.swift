import UIKit


extension UIButton.Configuration {
    static func cartButtonConfiguration(with image: UIImage?) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        configuration.image = image
        configuration.background.strokeWidth = 1.0
        configuration.background.strokeColor = .black
        configuration.baseForegroundColor = .black
        return configuration
    }
}

extension UIButton {
    func addShadow(
        shadowColor: CGColor = UIColor.label.cgColor,
        shadowOffset: CGSize,
        shadowRadius: CGFloat = 3.0,
        shadowOpacity: Float = 0.3
    ) {
        self.layer.shadowColor = UIColor.label.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.masksToBounds = false
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
    }
}

extension UIButton {
    func setupButton(
        title: String = "",
        cornerRadius: CGFloat = 0,
        width: CGFloat
    ) {
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = cornerRadius
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
