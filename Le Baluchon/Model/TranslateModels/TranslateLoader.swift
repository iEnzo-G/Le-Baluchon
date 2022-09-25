
import Foundation

final class TranslateLoader {
    
    let client: TranslateSession
    
    init(client: TranslateSession = .init()) {
        self.client = client
    }
    
    func load(text: String, completion: @escaping (Result<TranslateResponse, Error>) -> Void) {
        let baseURL = URL(string: "https://api-free.deepl.com/v2/translate")!
        let urlRequest = TranslateEndpoint.post(text).urlRequest(baseURL: baseURL)
        client.get (request: urlRequest) { [weak self] result in
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
