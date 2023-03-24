import UIKit

final class ProductDetailView: UIView {
    private let viewModel: ProductDetailViewViewModel
    
    // MARK: - Views
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProductImagesCollectionViewCell.self, forCellWithReuseIdentifier: ProductImagesCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontSize: 22, fontWeight: .medium, numberOfLines: 2)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontSize: 18, fontWeight: .medium)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontSize: 24, fontWeight: .bold)
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontSize: 16, fontWeight: .bold)
        return label
    }()
    
    private lazy var addToCartButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        configuration.image = .systemCartImage
        configuration.imagePadding = 10
        configuration.background.cornerRadius = 12
        configuration.baseForegroundColor = .white
        configuration.title = Strings.ProductDetailView.addToCartButtonTitle
        configuration.background.backgroundColor = .black
        let button = UIButton(configuration: configuration)
        button.addShadow(shadowOffset: CGSize(width: 1.0, height: 5.0))
        button.addTarget(viewModel, action: #selector(viewModel.addToCartButtonTapped), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.8).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    required init(viewModel: ProductDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        addSubviews(collectionView, nameLabel, descriptionLabel, priceLabel, categoryLabel, addToCartButton)
        addConstraints()
        setUpCollectionView()
        setUpData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    // MARK: - Set Up View
    private func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 200),
            
            nameLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 80),
            
            categoryLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: -7),
            categoryLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            categoryLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            categoryLabel.heightAnchor.constraint(equalToConstant: 40),
            
            priceLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 7),
            priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            priceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            priceLabel.heightAnchor.constraint(equalToConstant: 60),
            
            addToCartButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
            addToCartButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addToCartButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
    
    private func setUpData() {
        nameLabel.text = viewModel.product.title
        descriptionLabel.text = Strings.ProductDetailView.description + viewModel.product.description
        categoryLabel.text = Strings.ProductDetailView.category + viewModel.product.category.name
        priceLabel.text =  PriceFormatter.convertPriceWithSeparator(viewModel.product.price, currencyCode: Locale.current.currencySymbol ?? "USD")
    }
}
