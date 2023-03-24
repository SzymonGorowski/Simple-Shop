import UIKit

protocol AccountViewViewModelDelegate: AnyObject {
    func didSelectSection(_ section: AccountSection)
}

final class AccountViewViewModel: NSObject {
    private let sections: [AccountSection] = AccountSection.dummyData
    
    public weak var delegate: AccountViewViewModelDelegate?
}

// MARK: Extensions
extension AccountViewViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.identifier, for: indexPath) as? AccountTableViewCell else {
            fatalError("Unsupported cell")
        }
        let section = sections[indexPath.row]
        cell.configure(with: section)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let section = sections[indexPath.row]
        delegate?.didSelectSection(section)
    }
}
