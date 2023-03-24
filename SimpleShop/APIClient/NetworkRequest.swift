import Foundation

final class NetworkRequest {
    private struct Constants {
        static let baseURL = "https://api.escuelajs.co/api/v1"
    }
    
    private let endpoint: Endpoint
    private let pathComponents: [String]
    private let queryParameters: [URLQueryItem]
    
    private var urlString: String {
        var string = Constants.baseURL
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach { string += "/\($0)" }
        }
        
        if !queryParameters.isEmpty {
            string += "/?"
            let argumentString = queryParameters
                .compactMap {
                    guard let value = $0.value else { return nil }
                    return "\($0.name)=\(value)"
                }
                .joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    public var url: URL? {
        return URL(string: urlString )
    }
    
    public let httpMethod = "GET"
    
    // MARK: - Init
    public init(endpoint: Endpoint,
                pathComponents: [String] = [],
                queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}

extension NetworkRequest {
    static let listCategoryRequest = NetworkRequest(endpoint: .categories)
    static let listProductRequest = NetworkRequest(endpoint: .products)
}
