import UIKit
import Combine

final class CartItemCollectionViewCell: UICollectionViewCell {
    static var identifier: String { return String(describing: self) }
    
    private var cartItem: CartItem?
    private var bindings = Set<AnyCancellable>()
    private let cartView = CartView()
    private var indexPath = IndexPath(index: .zero)

    // MARK: - Views
    private let itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.setupImageView(contentMode: .scaleAspectFill)
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private let itemNameLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontSize: 14, fontWeight: .semibold)
        return label
    }()
    
    private let itemPriceLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontSize: 14, fontWeight: .semibold)
        return label
    }()
    
    private lazy var nameAndPriceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [itemNameLabel, itemPriceLabel])
        stackView.setupStackView(axis: .vertical, alignment: .leading, spacing: 10)
        return stackView
    }()
    
    private lazy var itemStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [itemImage, nameAndPriceStackView])
        stackView.setupStackView(axis: .horizontal, alignment: .leading, spacing: 10)
        return stackView
    }()
    
    private lazy var deleteItemButton: UIButton = {
        let button = UIButton(configuration: .cartButtonConfiguration(with: UIImage.systemTrash))
        button.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
        button.setupButton(width: 44)
        return button
    }()
    
    private lazy var increaseItemQuantityButton: UIButton = {
        let button = UIButton(configuration: .cartButtonConfiguration(with: UIImage.systemPlusImage))
        button.addTarget(self, action: #selector(increaseQuantity), for: .touchUpInside)
        button.setupButton(width: 44)
        return button
    }()
    
    private lazy var decreaseItemQuantityButton: UIButton = {
        let button = UIButton(configuration: .cartButtonConfiguration(with: UIImage.systemMinusImage))
        button.addTarget(self, action: #selector(decreaseQuantity), for: .touchUpInside)
        button.setupButton(width: 44)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [decreaseItemQuantityButton, increaseItemQuantityButton, deleteItemButton])
        stackView.setupStackView(axis: .horizontal, alignment: .center, spacing: 10)
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let itemQuantityLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontSize: 16, fontWeight: .bold)
        return label
    }()
    
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontSize: 16, fontWeight: .bold)
        return label
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [itemQuantityLabel, totalPriceLabel])
        stackView.setupStackView(axis: .horizontal, alignment: .center, spacing: 10)
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(itemStackView, buttonStackView, labelStackView)
        setUpLayer(shadowOffset: CGSize(width: -4, height: 4))
        addConstraints()
        setupBinding()
    }
    
    required init(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Set Up View
    private func addConstraints() {
        NSLayoutConstraint.activate([
            itemStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            itemStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            itemStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            itemStackView.heightAnchor.constraint(equalToConstant: 90),
            
            buttonStackView.topAnchor.constraint(equalTo: itemStackView.bottomAnchor, constant: 10),
            buttonStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            
            labelStackView.leftAnchor.constraint(equalTo: buttonStackView.rightAnchor, constant: 20),
            labelStackView.centerYAnchor.constraint(equalTo: buttonStackView.centerYAnchor),
        ])
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpLayer(shadowOffset: CGSize(width: -4, height: 4))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImage.image = nil
        itemNameLabel.text = nil
        itemPriceLabel.text = nil
        itemQuantityLabel.text = nil
        totalPriceLabel.text = nil
    }
    
    // MARK: Private
    private func setupBinding() {
        cartItem?.$quantity
            .map { "\($0) pcs" }
            .assign(to: \.text, on: itemQuantityLabel)
            .store(in: &bindings)
        }
    
    @objc
    private func increaseQuantity() {
        guard let cartItem else { return }
        Cart.shared.addItem(cartItem.product)
        totalPriceLabel.text = PriceFormatter.convertPriceWithSeparator(cartItem.totalPrice,
                                                                        currencyCode: Locale.current.currencySymbol ?? "USD")
        if cartItem.quantity > 1 {
            decreaseItemQuantityButton.isEnabled = true
        }
    }
    
    @objc
    private func decreaseQuantity() {
        guard let cartItem else { return }
        Cart.shared.removeItem(cartItem.product)
        totalPriceLabel.text = PriceFormatter.convertPriceWithSeparator(cartItem.totalPrice,
                                                                        currencyCode: Locale.current.currencySymbol ?? "USD")
        if cartItem.quantity == 1 {
            decreaseItemQuantityButton.isEnabled = false
        }
    }
    
    @objc
    private func deleteItem() {
        guard let cartItem else { return }
        Cart.shared.deleteItem(cartItem.product)
    }
    
    //MARK: Configuration of cell
    func configure(with item: CartItem, at index: IndexPath) {
        indexPath = index
        self.cartItem = item
        setupBinding()
        itemNameLabel.text = item.product.title
        itemPriceLabel.text = PriceFormatter.convertPriceWithSeparator(item.product.price, currencyCode: Locale.current.currencySymbol ?? "USD")
        totalPriceLabel.text = PriceFormatter.convertPriceWithSeparator(item.totalPrice, currencyCode: Locale.current.currencySymbol ?? "USD")
        if let cartItem {
            decreaseItemQuantityButton.isEnabled = cartItem.quantity > 1
        }
        
        guard let imageURL = URL(string: item.product.images.first ?? "") else { return }
        ImageFetcher.fetchImage(from: imageURL) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.itemImage.image = image
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
