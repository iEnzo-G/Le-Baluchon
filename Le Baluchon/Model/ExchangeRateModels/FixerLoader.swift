import Foundation

final class FixerLoader {
    
   private let client: HTTPClient
    
    init(client: HTTPClient = URLSessionHTTPClient()) {
        self.client = client
    }
    
    
    
    func load(to: String, from: String, completion: @escaping (Result<FixerItem, Error>) -> Void) {
        let baseURL = URL(string: "https://api.apilayer.com/fixer")!
        let url = FixerEndpoint.get(to: to, from: from).url(baseURL: baseURL)
        client.get(url: URLRequest(url: url)) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success((data, response)):
                do {
                    let result = try FixerMapper.map(data: data, response: response)
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
