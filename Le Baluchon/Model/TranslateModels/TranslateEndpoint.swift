import Foundation

enum TranslateEndpoint {
    case post(String)
    
    func urlRequest(baseURL: URL) -> URLRequest {
        switch self {
        case let .post(text):
            var request = URLRequest(url: baseURL)
            request.httpMethod = "POST"
            let body = "text=" + text + "&target_lang=EN"
            request.httpBody = body.data(using: .utf8)
            request.allHTTPHeaderFields = ["Authorization" : "DeepL-Auth-Key " + APIConfig.translateKey]
            
            return request
        }
    }
}



    
