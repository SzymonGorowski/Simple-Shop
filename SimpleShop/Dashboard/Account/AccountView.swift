import UIKit

protocol AccountViewDelegate: AnyObject {
    func accountView(_ accountView: AccountView,
                     didSelectSection section: AccountSection)
}

final class AccountView: UIView {
    private let viewModel = AccountViewViewModel()

    weak var delegate: AccountViewDelegate?
    
    // MARK: - Views
    private let userInfoView = UserInfoView()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.cornerRadius = 12
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: AccountTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        addSubviews(userInfoView, tableView)
        viewModel.delegate = self
        addConstraints()
        setUpTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Set Up View
    private func addConstraints() {
        NSLayoutConstraint.activate([
            userInfoView.topAnchor.constraint(equalTo: topAnchor),
            userInfoView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            userInfoView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            userInfoView.heightAnchor.constraint(equalToConstant: 200),
            
            tableView.topAnchor.constraint(equalTo: userInfoView.bottomAnchor, constant: 20),
            tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setUpTableView() {
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
    }
}

// MARK: Extensions
extension AccountView: AccountViewViewModelDelegate {
    func didSelectSection(_ section: AccountSection) {
        delegate?.accountView(self, didSelectSection: section)
    }
}
