import UIKit

protocol OrderConfirmationViewDelegate: AnyObject {
    func orderConfirmationView(_ orderConfirmationView: OrderConfirmationView)
}

final class OrderConfirmationView: UIView {
    weak var delegate: OrderConfirmationViewDelegate?
    
    // MARK: - Views
    private let checkmarkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.setupImageView(contentMode: .scaleAspectFill)
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.layer.cornerRadius = 12
        imageView.image = .systemCheckmark
        imageView.tintColor = .systemGreen
        return imageView
    }()
    
    private let confirmTextLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(text: Strings.OrderConfirmationView.ConfirmTextLabel.title, fontSize: 26, fontWeight: .semibold, textAlignment: .center)
        return label
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setupButton(title: Strings.OrderConfirmationView.ConfirmButton.title,
                           cornerRadius: 12,
                           width: UIScreen.main.bounds.width * 0.8)
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        button.backgroundColor = .systemGreen
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        addSubviews(checkmarkImage, confirmTextLabel, confirmButton)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            checkmarkImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            checkmarkImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100),
            
            confirmTextLabel.topAnchor.constraint(equalTo: checkmarkImage.bottomAnchor, constant: 20),
            confirmTextLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            confirmTextLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            
            confirmButton.topAnchor.constraint(equalTo: confirmTextLabel.bottomAnchor, constant: 20),
            confirmButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    @objc
    private func confirmButtonTapped() {
        delegate?.orderConfirmationView(self)
    }
}
