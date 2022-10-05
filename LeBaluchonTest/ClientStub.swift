
import Foundation

class ClientStub: HTTPClient {
    
    let result: Result<(Data, HTTPURLResponse), Error>
    
    init(result: Result<(Data, HTTPURLResponse), Error>) {
        self.result = result
    }
    
    func get(url: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) {
        completion(result)
    }
}
