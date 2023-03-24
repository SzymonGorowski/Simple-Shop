import Foundation

struct ImageFetcher {
    static public func fetchImage(from imageURL: URL?, completion: @escaping(Result<Data, Error>) -> Void) {
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
