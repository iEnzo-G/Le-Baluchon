//
//  ExchangeRate.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 15/08/2022.
//

import Foundation

struct FixerResponse: Decodable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: [String: Double]
}

final class ExchangeRate {
// MARK: - Properties

    let formatter = NumberFormatter()
    var rates: String = "0"

// MARK: - Functions

private func numberFormatter() {
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 3
}

func getRates(response: FixerResponse) {
    rates = String(format:"%f", response.rates["USD"]!)
}
    
}
    // MARK: - Mapper

// The mapper will be use to decode the answer of API
final class ExchangeMapper {
    private init() {}
    
    static func map(data: Data, response: HTTPURLResponse) throws -> FixerResponse {
        guard response.statusCode == 200, let response = try? JSONDecoder().decode(FixerResponse.self, from: data) else {
            throw NetworkError.undecodableData
        }
        return response
    }
}

    // MARK: - Loader

final class ExchangeRateLoader {
    
    let client: URLSessionHTTPClient
    
    init(client: URLSessionHTTPClient = .init()) {
        self.client = client
    }
    
    func load(url: URL, completion: @escaping (Result<FixerResponse, Error>) -> Void) {
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
