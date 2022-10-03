//
//  ExchangeRateLoader.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 29/08/2022.
//

import Foundation

final class FixerLoader {
    
    let client: URLSessionHTTPClient
    
    init(client: URLSessionHTTPClient = .init()) {
        self.client = client
    }
    
    func load(to: String, from: String, completion: @escaping (Result<FixerResponse, Error>) -> Void) {
        let baseURL = URL(string: "https://api.apilayer.com/fixer")!
        let url = FixerEndpoint.get(to: to, from: from).url(baseURL: baseURL)
        client.get(url: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success((data, response)):
                do {
                    let result = try FixerMapper.map(data: data, response: response)
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
