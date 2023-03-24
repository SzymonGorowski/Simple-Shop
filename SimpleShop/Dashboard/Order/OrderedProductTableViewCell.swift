import UIKit

final class OrderedProductTableViewCell: UITableViewCell {
    
    static var identifier: String { return String(describing: self) }
    
    // MARK: - Views
    private let productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.setupImageView(contentMode: .scaleAspectFill)
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontSize: 14, fontWeight: .semibold)
        return label
    }()
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontSize: 14, fontWeight: .semibold)
        return label
    }()
    
    private lazy var nameAndPriceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [productNameLabel, productPriceLabel])
        stackView.setupStackView(axis: .vertical,
                                 alignment: .leading,
                                 spacing: 10)
        return stackView
    }()
    
    private lazy var productStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [productImage, nameAndPriceStackView])
        stackView.setupStackView(axis: .horizontal,
                                 alignment: .leading,
                                 spacing: 10)
        return stackView
    }()
    
    private let productQuantityLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontSize: 16, fontWeight: .bold)
        return label
    }()
    
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontSize: 16, fontWeight: .bold, textAlignment: .right)
        return label
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [productQuantityLabel, totalPriceLabel])
        stackView.setupStackView(axis: .horizontal,
                                 alignment: .fill,
                                 spacing: 10)
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.layer.borderColor = UIColor.secondaryLabel.cgColor
        contentView.layer.borderWidth = 1
        contentView.addSubviews(productStackView, labelStackView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Up View
    private func addConstraints() {
        NSLayoutConstraint.activate([
            productStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            productStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            productStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            productStackView.heightAnchor.constraint(equalToConstant: 90),

            labelStackView.topAnchor.constraint(equalTo: productStackView.bottomAnchor, constant: 10),
            labelStackView.leftAnchor.constraint(equalTo: productStackView.leftAnchor, constant: 10),
            labelStackView.rightAnchor.constraint(equalTo: productStackView.rightAnchor, constant: -10),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImage.image = nil
        productNameLabel.text = nil
        productPriceLabel.text = nil
        productQuantityLabel.text = nil
        totalPriceLabel.text = nil
    }
    
    // MARK: Cell configuration
    public func configure(with item: CartItem) {
        productNameLabel.text = item.product.title
        productPriceLabel.text = PriceFormatter.convertPriceWithSeparator(item.product.price, currencyCode: Locale.current.currencySymbol ?? "USD")
        totalPriceLabel.text = PriceFormatter.convertPriceWithSeparator(item.totalPrice, currencyCode: Locale.current.currencySymbol ?? "USD")
        productQuantityLabel.text = "\(item.quantity) pcs"
        
        guard let imageURL = URL(string: item.product.images.first ?? "") else { return }
        ImageFetcher.fetchImage(from: imageURL) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.productImage.image = image
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
