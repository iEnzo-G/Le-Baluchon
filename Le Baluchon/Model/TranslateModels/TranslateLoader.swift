import Foundation

final class TranslateLoader {
    
   private let client: HTTPClient
    
    init(client: HTTPClient = URLSessionHTTPClient()) {
        self.client = client
    }
    
    func load(text: String, completion: @escaping (Result<TranslateItem, Error>) -> Void) {
        let baseURL = URL(string: "https://api-free.deepl.com/v2/translate")!
        let urlRequest = TranslateEndpoint.post(text).urlRequest(baseURL: baseURL)
        client.get(url: urlRequest) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success((data, response)):
                do {
                    let result = try TranslateMapper.map(data: data, response: response)
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
