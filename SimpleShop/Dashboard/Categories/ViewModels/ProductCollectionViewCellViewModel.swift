import Foundation

final class ProductCollectionViewCellViewModel {
    let name: String
    let price: Int
    let imageURL: URL?

    // MARK: - Init
    init(name: String, imageURL: URL?, price: Int) {
        self.name = name
        self.imageURL = imageURL
        self.price = price
    }
}
