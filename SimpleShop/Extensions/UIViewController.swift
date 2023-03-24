import UIKit

extension UIViewController {
    func addView(_ view: UIView) {
        self.view.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            view.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            view.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension UIViewController {
    func pushViewController(_ vc: UIViewController) {
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
