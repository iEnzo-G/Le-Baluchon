import Foundation

final class WeatherLoader {
    
    private let client: HTTPClient
    
    init(client: HTTPClient = URLSessionHTTPClient()) {
        self.client = client
    }
    
    func load(cities: [Int], units: String, completion: @escaping (Result<WeatherItem, Error>) -> Void) {
        let baseURL = URL(string: "http://api.openweathermap.org/data/2.5")!
        let url = WeatherEndpoint.get(cities, units).url(baseURL: baseURL)
        client.get(url: URLRequest(url: url)) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success((data, response)):
                do {
                    let result = try WeatherMapper.map(data: data, response: response)
                    completion(.success(result))
                }  catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
