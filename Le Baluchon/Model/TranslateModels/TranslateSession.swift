//
//  TranslateSession.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 18/09/2022.
//

import Foundation

class TranslateSession {
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func get(request: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) {
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
