//
//  TranslateSession.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 18/09/2022.
//

import Foundation

class TranslateSession {
    private let session: URLSession
    
    init(session: URLSession = URLSession.init(configuration: .default)) {
        self.session = session
    }
    
    func get(frenchText: String,completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) {
        var request = URLRequest(url: URL(string: "https://api-free.deepl.com/v2/translate")!)
        request.httpMethod = "POST"
        let body = "text=" + frenchText + "&source_lang=FR&target_lang=EN"
        request.httpBody = body.data(using: .utf8)
        request.allHTTPHeaderFields = ["Authorization" : "DeepL-Auth-Key f419ed1c-47cd-33ac-fd74-cbff06750a2f:fx"]
        
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(NetworkError.invalidResponse))
                    return
                }
                completion(.success((data, response)))
            }
        }.resume()
    }
    
}
