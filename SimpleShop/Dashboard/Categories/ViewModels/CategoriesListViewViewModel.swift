import UIKit

protocol CategoriesListViewViewModelDelegate: AnyObject {
    func didLoadCategories()
    func didSelectCategory(_ category: Category)
}

final class CategoriesListViewViewModel: NSObject {
    weak var delegate: CategoriesListViewViewModelDelegate?
    
    private var categories: [Category] = [] {
        didSet {
            for category in categories {
                let viewModel = CategoryCollectionViewCellViewModel(name: category.name, imageURL: URL(string: category.image))
                cellViewModels.append(viewModel)
            }
        }
    }
    
    private var cellViewModels: [CategoryCollectionViewCellViewModel] = []
    
    func fetchCategories() {
        NetworkService.shared.execute(.listCategoryRequest, expecting: [Category].self) { result in
            switch result {
            case .success(let categories):
                self.categories = categories
                DispatchQueue.main.async {
                    self.delegate?.didLoadCategories()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

// MARK: Extensions
extension CategoriesListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier,
                                                            for: indexPath) as? CategoryCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let category = categories[indexPath.row]
        delegate?.didSelectCategory(category)
    }
}
