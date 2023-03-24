import UIKit

protocol UserDetailsViewDelegate: AnyObject {
    func userDetailsView(_ userDetails: UserDetailsView,
                         didTapContinue customer: Customer)
}

final class UserDetailsView: UIView {
    private let viewModel = UserDetailsViewViewModel()
    
    weak var delegate: UserDetailsViewDelegate?
    
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
    
    private lazy var checkbox: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(.systemSquare, for: .normal)
        button.addTarget(self, action: #selector(didTapCheckbox), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 36).isActive = true
        button.heightAnchor.constraint(equalToConstant: 36).isActive = true
        return button
    }()
    
    private lazy var checkboxLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(text: Strings.UserDetailsView.CheckboxLabel.title, fontSize: 16, fontWeight: .medium)
        return label
    }()
    
    private lazy var checkboxStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [checkboxLabel, checkbox])
        stackView.setupStackView(axis: .horizontal, alignment: .center, spacing: 10)
        return stackView
    }()
    
    private lazy var continueButton: CustomButton = {
        let button = CustomButton()
        button.setBackgroundColor(.black, for: .normal)
        button.setBackgroundColor(.gray, for: .disabled)
        button.isEnabled = false
        button.addShadow(shadowOffset: CGSize(width: 1.0, height: 5.0))
        button.setupButton(title: Strings.UserDetailsView.ContinueButton.title,
                           cornerRadius: 12,
                           width: UIScreen.main.bounds.width * 0.8)
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        addSubviews(checkboxStackView, continueButton, textFieldsStackView)
        addConstraints()
        getCustomerData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            continueButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            continueButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 66),
            
            checkboxStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            checkboxStackView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -20),
            
            textFieldsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            textFieldsStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            textFieldsStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
        ])
    }
    
    @objc
    private func didTapCheckbox() {
        viewModel.isChecked.toggle()
        
        if viewModel.isChecked {
            UIView.animate(withDuration: 0.3) {
                self.checkbox.setBackgroundImage(.systemCheckmark, for: .normal)
                self.continueButton.isEnabled = true
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.checkbox.setBackgroundImage(.systemSquare, for: .normal)
                self.continueButton.isEnabled = false
            }
        }
    }
    
    @objc
    private func continueButtonTapped() {
        if let customer = createCustomer(),
           areTextFieldsFilledCorrectly() {
            delegate?.userDetailsView(self, didTapContinue: customer)
            viewModel.saveCustomerDataInKeychain(customer)
        } else {
            presentAlert()
        }
    }
    
    private func areTextFieldsFilledCorrectly() -> Bool {
        let isEmailValid = viewModel.isEmailValid(emailTextField.text)
        let areNameAndAddressNotEmpty = viewModel.areNameAndAddressNotEmpty(nameTextField.text, addressTextField.text)
        let isPhoneNumberValid = viewModel.isPhoneNumberValid(phoneTextField.text)
        return isEmailValid && areNameAndAddressNotEmpty && isPhoneNumberValid
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
    
    private func presentAlert() {
        let alert = UIAlertController(title: Strings.UserDetailsView.Alert.title,
                                      message: Strings.UserDetailsView.Alert.message,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: Strings.UserDetailsView.Alert.buttonTitle,
                                      style: .default,
                                      handler: { _ in
        }))

        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
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
}
