import UIKit

final class AccountTableViewCell: UITableViewCell {
    static var identifier: String { return String(describing: self) }
    
    // MARK: - Views
    private let labelIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.setupImageView(contentMode: .scaleAspectFit)
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.setupLabel(fontSize: 18, fontWeight: .medium)
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(labelIcon, nameLabel)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Up View
    private func addConstraints() {
        NSLayoutConstraint.activate([
            labelIcon.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelIcon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            labelIcon.widthAnchor.constraint(equalToConstant: 40),
            labelIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.leftAnchor.constraint(equalTo: labelIcon.rightAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -7),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        labelIcon.image = nil
        nameLabel.text = nil
    }
    
    // MARK: Cell configuration
    public func configure(with section: AccountSection) {
        nameLabel.text = section.name
        labelIcon.image = UIImage(systemName: section.systemImage)
    }
}
