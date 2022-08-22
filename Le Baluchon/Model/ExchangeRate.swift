//
//  ExchangeRate.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 15/08/2022.
//

import Foundation

struct Currency: Decodable {
    var result: String
    var rate: String
}

class ExchangeRate {
    
    // MARK: - Properties
    
    private let session: URLSession
    static let amount: String = "1"
    
    init(session: URLSession = URLSession.init(configuration: .default)) {
        self.session = session
    }
    
    // MARK: - Request function
    
    func getCurrency(url: URL, completion: @escaping (Result<(Data, URLResponse), Error>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Vxvy8dMQlAuKjbvNvkInyxUM6zpzz9JG", forHTTPHeaderField: "apikey")
        
        let task = session.dataTask(with: request) { data, response, error in
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
        
        task.resume()
    }
}

    // MARK: - Mapper

// The mapper will be use to decode the answer of API
class ExchangeMapper {
    private init() {}
    
    static func map(data: Data, response: HTTPURLResponse) throws -> Currency {
        guard response.statusCode == 200, let currency = try? JSONDecoder().decode(Currency.self, from: data) else {
            throw NetworkError.undecodableData
        }
        return currency
    }
}
