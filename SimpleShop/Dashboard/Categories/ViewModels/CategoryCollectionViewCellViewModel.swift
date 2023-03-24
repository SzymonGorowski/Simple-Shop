import Foundation

final class CategoryCollectionViewCellViewModel {
    let name: String
    private let imageURL: URL?
    
    // MARK: - Init
    init(name: String, imageURL: URL?) {
        self.name = name
        self.imageURL = imageURL
    }
    
    public func fetchImage(completion: @escaping(Result<Data, Error>) -> Void) {
        guard let url = imageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
