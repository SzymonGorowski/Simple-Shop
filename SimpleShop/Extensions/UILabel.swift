import UIKit

extension UILabel {
    func setupLabel(
        text: String = "",
        fontSize: CGFloat,
        fontWeight: UIFont.Weight,
        textColor: UIColor = .label,
        textAlignment: NSTextAlignment = .left,
        numberOfLines: Int = 0,
        lineBreakMode: NSLineBreakMode = .byWordWrapping
    ) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.lineBreakMode = lineBreakMode
        self.text = text
    }
}
