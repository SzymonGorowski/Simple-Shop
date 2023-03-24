import UIKit

protocol ConfirmOrderViewDelegate: AnyObject {
    func confirmOrderView(_ confirmView: ConfirmOrderView)
}

final class ConfirmOrderView: UIScrollView {
    private let viewModel: ConfirmOrderViewViewModel
    
    weak var viewDelegate: ConfirmOrderViewDelegate?

    // MARK: - Views
    private lazy var userDetailsLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(text: Strings.ConfirmOrderView.UserDetailsLabel.title,
                         fontSize: 20,
                         fontWeight: .semibold,
                         textAlignment: .center)
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        createLabel(headline: Strings.ConfirmOrderView.NameLabel.title, body: viewModel.customer.name)
    }()
    
    private lazy var emailLabel: UILabel = {
        createLabel(headline: Strings.ConfirmOrderView.EmailLabel.title, body: viewModel.customer.name)
    }()
    
    private lazy var addressLabel: UILabel = {
        createLabel(headline: Strings.ConfirmOrderView.AddressLabel.title, body: viewModel.customer.name)
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        createLabel(headline: Strings.ConfirmOrderView.PhoneNumberLabel.title, body: viewModel.customer.name)
    }()
    
    private lazy var userDetailsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            userDetailsLabel, nameLabel, emailLabel, addressLabel, phoneNumberLabel
        ])
        stackView.setupStackView(axis: .vertical, alignment: .leading, spacing: 10)
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 8
        stackView.layer.shadowColor = UIColor.label.cgColor
        stackView.layer.shadowRadius = 4
        stackView.layer.shadowOffset = CGSize(width: -2, height: 2)
        stackView.layer.shadowOpacity = 0.3
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
        return stackView
    }()
    
    private func createLabel(headline: String, body: String) -> UILabel {
        let label = UILabel()
        label.setupLabel(text: "\(headline): \(body)", fontSize: 16, fontWeight: .regular)
        return label
    }
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isScrollEnabled = false
        table.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
        table.register(OrderedProductTableViewCell.self, forCellReuseIdentifier: OrderedProductTableViewCell.identifier)
        return table
    }()
    
    private let totalOrderAmountLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(
            text: "Total: \(PriceFormatter.convertPriceWithSeparator(Cart.shared.total, currencyCode: "USD"))",
            fontSize: 18,
            fontWeight: .semibold,
            textAlignment: .right)
        label.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
        return label
    }()
    
    private lazy var paymentMethodsLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(text: Strings.ConfirmOrderView.PaymentMethodsLabel.title,
                         fontSize: 20,
                         fontWeight: .semibold)
        return label
    }()
    
    private lazy var cashPaymentMethodButton: UIButton = {
        createPaymentMethodButton(for: .cash)
    }()
    
    private lazy var bankTransferPaymentMethodButton: UIButton = {
        createPaymentMethodButton(for: .bankTransfer)
    }()
    
    private lazy var blikPaymentMethodButton: UIButton = {
        createPaymentMethodButton(for: .blik)
    }()
    
    private func createPaymentMethodButton(for method: PaymentMethod) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle(method.displayTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 8
        button.tag = method.tag
        button.addShadow(shadowOffset: CGSize(width: 1.0, height: 2.0))
        button.addTarget(self, action: #selector(paymentMethodButtonTapped(_:)), for: .touchUpInside)
        
        if method.tag == 1 {
            button.layer.borderWidth = 3
            button.layer.borderColor = UIColor.systemGreen.cgColor
        }
        return button
    }
    
    private lazy var paymentMethodsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            cashPaymentMethodButton, bankTransferPaymentMethodButton, blikPaymentMethodButton
        ])
        stackView.setupStackView(axis: .horizontal, alignment: .fill, spacing: 10)
        stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var deliveryMethodsLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(text: Strings.ConfirmOrderView.DeliveryMethodsLabel.title,
                         fontSize: 20,
                         fontWeight: .semibold)
        return label
    }()
    
    private func createDeliveryMethodButton(for method: DeliveryMethod) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle(method.displayTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.addShadow(shadowOffset: CGSize(width: 1.0, height: 2.0))
        button.layer.cornerRadius = 8
        button.tag = method.tag
        button.addTarget(self, action: #selector(deliveryMethodButtonTapped(_:)), for: .touchUpInside)
        
        if method.tag == 1 {
            button.layer.borderWidth = 3
            button.layer.borderColor = UIColor.systemGreen.cgColor
        }
        return button
    }

    
    private lazy var personalCollectionDeliveryMethodButton: UIButton = {
        createDeliveryMethodButton(for: .personalCollection)
    }()
    
    private lazy var fastDeliveryMethodButton: UIButton = {
        createDeliveryMethodButton(for: .fastDelivery)
    }()
    
    private lazy var standardDeliveryMethodButton: UIButton = {
        createDeliveryMethodButton(for: .standardDelivery)
    }()
    
    private lazy var deliveryMethodsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            personalCollectionDeliveryMethodButton,
            fastDeliveryMethodButton,
            standardDeliveryMethodButton
        ])
        stackView.setupStackView(axis: .vertical, alignment: .fill, spacing: 10)
        stackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var confirmButton: CustomButton = {
        let button = CustomButton()
        button.setupButton(title: Strings.ConfirmOrderView.ConfirmButton.title,
                           cornerRadius: 12,
                           width: UIScreen.main.bounds.width * 0.8)
        button.setBackgroundColor(.black, for: .normal)
        button.setBackgroundColor(.gray, for: .disabled)
        button.addShadow(shadowOffset: CGSize(width: 1.0, height: 5.0))
        button.isEnabled = true
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Init
    init(viewModel: ConfirmOrderViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemBackground
        addSubviews(userDetailsStackView,
                    tableView,
                    totalOrderAmountLabel,
                    paymentMethodsLabel,
                    paymentMethodsStackView,
                    deliveryMethodsLabel,
                    deliveryMethodsStackView,
                    confirmButton)
        addConstraints()
                
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        
        calculateHeightOfScrollView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    /// Calculate dynamically height of scrollView
    private func calculateHeightOfScrollView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            let height: CGFloat = self.subviews.map { $0.frame.height }.reduce(0) { $0 + $1 } + 150
            self.contentSize = CGSizeMake(UIScreen.main.bounds.width, height)
            self.layoutIfNeeded()
        })
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            userDetailsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            userDetailsStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            
            tableView.topAnchor.constraint(equalTo: userDetailsStackView.bottomAnchor, constant: 10),
            tableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            // calculation of tableView height based on header height and quantity of items in cart
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(60 + 150 * Cart.shared.items.count)),
            
            totalOrderAmountLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            totalOrderAmountLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            paymentMethodsLabel.topAnchor.constraint(equalTo: totalOrderAmountLabel.bottomAnchor, constant: 20),
            paymentMethodsLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            
            paymentMethodsStackView.topAnchor.constraint(equalTo: paymentMethodsLabel.bottomAnchor, constant: 10),
            paymentMethodsStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            paymentMethodsStackView.heightAnchor.constraint(equalToConstant: 80),
          
            deliveryMethodsLabel.topAnchor.constraint(equalTo: paymentMethodsStackView.bottomAnchor, constant: 20),
            deliveryMethodsLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),

            deliveryMethodsStackView.topAnchor.constraint(equalTo: deliveryMethodsLabel.bottomAnchor, constant: 10),
            deliveryMethodsStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            deliveryMethodsStackView.heightAnchor.constraint(equalToConstant: 180),
            
            confirmButton.topAnchor.constraint(equalTo: deliveryMethodsStackView.bottomAnchor, constant: 15),
            confirmButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: 66)
            ])
    }
    
    @objc
    private func paymentMethodButtonTapped(_ sender: UIButton) {
        if sender.tag == 1 {
            viewModel.selectedPaymentMethod = .cash
            viewModel.addBorderToButton(sender)
            viewModel.removeBorderFromButtons([bankTransferPaymentMethodButton, blikPaymentMethodButton])
        } else if sender.tag == 2 {
            viewModel.selectedPaymentMethod = .bankTransfer
            viewModel.addBorderToButton(sender)
            viewModel.removeBorderFromButtons([cashPaymentMethodButton, blikPaymentMethodButton])
        } else {
            viewModel.selectedPaymentMethod = .blik
            viewModel.addBorderToButton(sender)
            viewModel.removeBorderFromButtons([bankTransferPaymentMethodButton, cashPaymentMethodButton])
        }
    }
    
    @objc
    private func deliveryMethodButtonTapped(_ sender: UIButton) {
        if sender.tag == 1 {
            viewModel.selectedDeliveryMethod = .personalCollection
            viewModel.addBorderToButton(sender)
            viewModel.removeBorderFromButtons([fastDeliveryMethodButton, standardDeliveryMethodButton])
        } else if sender.tag == 2 {
            viewModel.selectedDeliveryMethod = .fastDelivery
            viewModel.addBorderToButton(sender)
            viewModel.removeBorderFromButtons([personalCollectionDeliveryMethodButton, standardDeliveryMethodButton])
        } else {
            viewModel.selectedDeliveryMethod = .standardDelivery
            viewModel.addBorderToButton(sender)
            viewModel.removeBorderFromButtons([personalCollectionDeliveryMethodButton, fastDeliveryMethodButton])
        }
    }
    
    @objc
    private func continueButtonTapped() {
        viewDelegate?.confirmOrderView(self)
        // Place order on the backend
    }
}
