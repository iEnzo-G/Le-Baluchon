
import Foundation

final class TranslateLoader {
    
    let client: TranslateSession
    
    init(client: TranslateSession = .init()) {
        self.client = client
    }
    
    func load(frenchText: String, completion: @escaping (Result<TranslateResponse, Error>) -> Void) {
        client.get (frenchText: frenchText) { [weak self] result in
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
