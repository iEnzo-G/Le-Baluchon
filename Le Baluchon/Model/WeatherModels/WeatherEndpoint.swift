import Foundation

enum WeatherEndpoint {
    case get([Int], String)
    
    func url(baseURL: URL) -> URL {
        switch self {
        case let .get(cities, units):
            var components = URLComponents()
            
            components.scheme = baseURL.scheme
            components.host = baseURL.host
            components.path = baseURL.path + "/group"
            components.queryItems = [
                URLQueryItem(name: "id", value: "\(cities.map(String.init).joined(separator: ","))"),
                URLQueryItem(name: "units", value: units),
                URLQueryItem(name: "apikey", value: APIConfig.weatherKey)
            ]
            
            return components.url!
        }
    }
}
