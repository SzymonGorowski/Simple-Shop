import UIKit

final class DiscountCollectionViewCell: UICollectionViewCell {
    static var identifier: String { return String(describing: self) }

    // MARK: - Views
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.setupImageView(contentMode: .scaleAspectFit)
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontSize: 18, fontWeight: .medium)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontSize: 14, fontWeight: .regular)
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView, nameLabel, dateLabel)
        setUpLayer(shadowOffset: CGSize(width: 2, height: 2))
        addConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Set Up View
    private func addConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
        
            dateLabel.heightAnchor.constraint(equalToConstant: 40),
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7),
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            nameLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor),

            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3),
        ])
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpLayer(shadowOffset: CGSize(width: 2, height: 2))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        dateLabel.text = nil
    }
    
    // MARK: Cell configuration
    func configure(with discount: Discount) {
        nameLabel.text = discount.name
        imageView.image = UIImage(systemName: discount.image)
        dateLabel.text = discount.expiryDate
    }
}
