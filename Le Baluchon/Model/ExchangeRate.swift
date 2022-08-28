//
//  ExchangeRate.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 15/08/2022.
//

import Foundation

struct CurrencyResponse: Decodable {
    let succes: Bool
    let timestamp: Int
    let base, date: String
    let rates: [String: Double]
}

    // MARK: - Mapper

// The mapper will be use to decode the answer of API
final class ExchangeMapper {
    private init() {}
    
    static func map(data: Data, response: HTTPURLResponse) throws -> CurrencyResponse {
        guard response.statusCode == 200, let currency = try? JSONDecoder().decode(CurrencyResponse.self, from: data) else {
            throw NetworkError.undecodableData
        }
        return currency
    }
}

    // MARK: - Loader

final class ExchangeRateLoader {
    
    let client: URLSessionHTTPClient
    
    init(client: URLSessionHTTPClient = .init()) {
        self.client = client
    }
    
    func load(url: URL, completion: @escaping (Result<CurrencyResponse, Error>) -> Void) {
        client.get(url: url) { result in
            switch result {
            case let .success((data, response)):
                do {
                    let result = try ExchangeMapper.map(data: data, response: response)
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
