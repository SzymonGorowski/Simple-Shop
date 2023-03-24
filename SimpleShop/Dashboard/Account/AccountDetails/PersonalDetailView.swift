import UIKit

final class PersonalDetailView: UIView {
        
    // MARK: - Views
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.setupRoundedTextField(placeholderText: Strings.UserDetailsView.NameTextField.placeholder)
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.setupRoundedTextField(placeholderText: Strings.UserDetailsView.EmailTextField.placeholder)
        return textField
    }()
    
    private lazy var addressTextField: UITextField = {
        let textField = UITextField()
        textField.setupRoundedTextField(placeholderText: Strings.UserDetailsView.AddressTextField.placeholder)
        return textField
    }()
    
    private lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.setupRoundedTextField(placeholderText: Strings.UserDetailsView.PhoneTextField.placeholder)
        return textField
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, emailTextField, addressTextField, phoneTextField])
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var updateButton: CustomButton = {
        let button = CustomButton()
        button.setBackgroundColor(.black, for: .normal)
        button.addShadow(shadowOffset: CGSize(width: 1.0, height: 5.0))
        button.setupButton(title: Strings.PersonalDetailView.UpdateButton.title,
                           cornerRadius: 12,
                           width: UIScreen.main.bounds.width * 0.8)
        button.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        addSubviews(textFieldsStackView, updateButton)
        addConstraints()
        getCustomerData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Set Up View
    private func addConstraints() {
        NSLayoutConstraint.activate([
            textFieldsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            textFieldsStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            textFieldsStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),

            updateButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 40),
            updateButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            updateButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc
    private func updateButtonTapped() {
        guard let customer = createCustomer() else { return }
        let keychain = CustomerDataKeychain()
        do {
            try keychain.store(customer)
            print("✅: Customer data stored in the Keychain")
            
            presentAlert()
        } catch {
            print("❌: Error when storing in the Keychain -> \(error.localizedDescription)")
        }
    }
    
    private func createCustomer() -> Customer? {
        guard let name = nameTextField.text,
              let address = addressTextField.text,
              let email = emailTextField.text,
              let number = phoneTextField.text else {
            return nil
        }
        
        return Customer(name: name, email: email, address: address, phoneNumber: number)
    }
    
    private func getCustomerData() {
        let keychain = CustomerDataKeychain()
        
        do {
            let customer = try keychain.retrieve()
            nameTextField.text = customer.name
            addressTextField.text = customer.address
            emailTextField.text = customer.email
            phoneTextField.text = customer.phoneNumber
        } catch {
            print("❌: Error when retrieving from the Keychain -> \(error.localizedDescription)")
        }
    }
    
    private func presentAlert() {
        let alert = UIAlertController(title: Strings.PersonalDetailView.Alert.title,
                                      message: Strings.PersonalDetailView.Alert.message,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: Strings.PersonalDetailView.Alert.buttonTitle,
                                      style: .default,
                                      handler: { _ in
        }))

        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
