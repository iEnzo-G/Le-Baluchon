//
//  URLSessionHTTPClient.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 15/08/2022.
//

import Foundation

protocol HTTPClient {
    func get(url: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void)
}

class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func get(url: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) {
        session.dataTask(with: url) { data, response, error in
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
