import Foundation

final class NetworkService {
    enum ServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    static let shared = NetworkService()
    
    private init() {}
    
    public func execute<T: Codable>(
        _ request: NetworkRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(ServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ServiceError.failedToGetData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(type, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    private func request(from request: NetworkRequest) -> URLRequest? {
        guard let url = request.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod
        return urlRequest
    }
}
