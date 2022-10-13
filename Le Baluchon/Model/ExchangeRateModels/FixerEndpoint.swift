import Foundation

enum FixerEndpoint{
    case get(to: String, from: String)
    
    func url(baseURL: URL) -> URL {
        switch self {
        case let .get(to, from):
            var components = URLComponents()
            
            components.scheme = baseURL.scheme
            components.host = baseURL.host
            components.path = baseURL.path + "/latest"
            components.queryItems = [
                URLQueryItem(name: "symbols", value: "\(to)"),
                URLQueryItem(name: "base", value: "\(from)"),
                URLQueryItem(name: "apikey", value: APIConfig.fixerKey)
            ]
            return components.url!
        }
    }
}
