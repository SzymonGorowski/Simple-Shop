import UIKit
import Combine

protocol CartViewDelegate: AnyObject {
    func cartView(_ cartView: CartView)
}

final class CartView: UIView {
    private let viewModel = CartViewViewModel()
    private var bindings = Set<AnyCancellable>()
    
    weak var delegate: CartViewDelegate?

    // MARK: - Views
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.setupCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CartItemCollectionViewCell.self, forCellWithReuseIdentifier: CartItemCollectionViewCell.identifier)
        collectionView.layer.opacity = 0
        collectionView.isHidden = true
        return collectionView
    }()
    
    private lazy var orderButton: CustomButton = {
        let button = CustomButton()
        button.setupButton(title: Strings.CartView.orderButtonTitle,
                           cornerRadius: 12,
                           width: UIScreen.main.bounds.width * 0.8)
        button.setBackgroundColor(.black, for: .normal)
        button.setBackgroundColor(.gray, for: .disabled)
        button.addShadow(shadowOffset: CGSize(width: 1.0, height: 5.0))
        button.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let totalOrderAmountLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(
            text: "Total: \(PriceFormatter.convertPriceWithSeparator(Cart.shared.total, currencyCode: "USD"))",
            fontSize: 18,
            fontWeight: .semibold
        )
        return label
    }()
    
    private let emptyCartLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(text: Strings.CartView.emptyCartLabelTitle,
                         fontSize: 24,
                         fontWeight: .semibold,
                         textAlignment: .center)
        return label
    }()
    
    @objc func orderButtonTapped() {
        delegate?.cartView(self)
    }
    
    func checkIfCartIsEmpty(_ itemsCount: Int) {
        if itemsCount >= 1 {
            orderButton.isEnabled = true
            collectionView.isHidden = false
            collectionView.layer.opacity = 1
            emptyCartLabel.layer.opacity = 0
            collectionView.reloadData()
        } else {
            orderButton.isEnabled = false
            emptyCartLabel.layer.opacity = 1
            collectionView.reloadData()
        }
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        addSubviews(collectionView, orderButton, emptyCartLabel, totalOrderAmountLabel)
        addConstraints()
        setUpCollectionView()
        setupBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Set Up View
    private func addConstraints() {
        NSLayoutConstraint.activate([
            orderButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            orderButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            orderButton.heightAnchor.constraint(equalToConstant: 66),
            
            totalOrderAmountLabel.bottomAnchor.constraint(equalTo: orderButton.topAnchor, constant: -10),
            totalOrderAmountLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            totalOrderAmountLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            totalOrderAmountLabel.heightAnchor.constraint(equalToConstant: 33),
            
            emptyCartLabel.topAnchor.constraint(equalTo: topAnchor),
            emptyCartLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            emptyCartLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            emptyCartLabel.heightAnchor.constraint(equalToConstant: 200),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: totalOrderAmountLabel.topAnchor, constant: -10)
        ])
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
    
    private func setupBinding() {
        Cart.shared.$total
            .map { "Total: \(PriceFormatter.convertPriceWithSeparator($0, currencyCode: "USD"))" }
            .assign(to: \.text, on: totalOrderAmountLabel)
            .store(in: &bindings)
        
        Cart.shared.$items.sink { [weak self] item in
            guard let self else { return }
            self.checkIfCartIsEmpty(item.count)
        }
        .store(in: &bindings)
    }
}
