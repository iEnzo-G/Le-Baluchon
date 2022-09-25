
import Foundation

final class TranslateLoader {
    
    let client: URLSessionHTTPClient
    
    init(client: URLSessionHTTPClient = .init()) {
        self.client = client
    }
    
    func load(text: String, completion: @escaping (Result<TranslateResponse, Error>) -> Void) {
        let baseURL = URL(string: "https://api-free.deepl.com/v2/translate")!
        let url = TranslateEndpoint.post(text).url(baseURL: baseURL)
        client.get (url: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success((data, response)):
                do {
                    let result = try TranslateMapper.map(data: data, response: response)
                    completion(.success(result))
                    return
                }  catch {
                    completion(.failure(error))
                    return
                }
            case let .failure(error):
                print(error.localizedDescription)
                return
            }
        }
    }
}
