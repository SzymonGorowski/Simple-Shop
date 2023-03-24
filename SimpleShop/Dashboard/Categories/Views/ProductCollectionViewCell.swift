import UIKit

final class ProductCollectionViewCell: UICollectionViewCell {
    static var identifier: String { return String(describing: self) }

    // MARK: - Views
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.setupImageView(contentMode: .scaleAspectFill)
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontSize: 18, fontWeight: .medium, numberOfLines: 2)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontSize: 20, fontWeight: .bold)
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView, nameLabel, priceLabel)
        setUpLayer(shadowOffset: CGSize(width: -4, height: 4))
        addConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Set Up View
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.widthAnchor.constraint(equalToConstant: contentView.bounds.width * 0.5),
            imageView.heightAnchor.constraint(equalToConstant: contentView.bounds.height),

            nameLabel.heightAnchor.constraint(equalToConstant: 80),
            nameLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 7),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -7),
            
            priceLabel.heightAnchor.constraint(equalToConstant: 50),
            priceLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 7),
            priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -7),
        ])
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpLayer(shadowOffset: CGSize(width: -4, height: 4))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        priceLabel.text = nil
    }
    
    // MARK: Cell configuration
    func configure(with viewModel: ProductCollectionViewCellViewModel) {
        nameLabel.text = viewModel.name
        priceLabel.text = PriceFormatter.convertPriceWithSeparator(viewModel.price, currencyCode: Locale.current.currencySymbol ?? "USD")
        
        ImageFetcher.fetchImage(from: viewModel.imageURL) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
