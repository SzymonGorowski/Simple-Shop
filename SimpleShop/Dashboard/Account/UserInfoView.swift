import UIKit

final class UserInfoView: UIView {
    
    // MARK: - Views
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.setupImageView(contentMode: .scaleAspectFit)
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontSize: 20, fontWeight: .medium)
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontSize: 18, fontWeight: .regular, textColor: .systemGray)
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 15
        addSubviews(imageView, nameLabel, emailLabel)
        addConstraints()
        setUpData()

    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Set Up View
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            nameLabel.rightAnchor.constraint(equalTo: imageView.leftAnchor, constant: -10),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            emailLabel.rightAnchor.constraint(equalTo: imageView.leftAnchor, constant: -10),
            emailLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
        ])
    }
    
    func setUpData() {
        getCustomerData()
        imageView.image = UIImage.systemPersonCircleFillImage
    }
    
    private func getCustomerData() {
        let keychain = CustomerDataKeychain()
        
        do {
            let customer = try keychain.retrieve()
            nameLabel.text = Strings.UserInfoView.NameLabel.title(customer.name)
            emailLabel.text = customer.email
        } catch {
            print("❌: Error when retrieving from the Keychain -> \(error.localizedDescription)")
        }
    }
}
