//
//  ExchangeRateMapper.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 29/08/2022.
//

import Foundation

// The mapper will be use to decode the answer of API
final class FixerMapper {
    private init() {}
    
    static func map(data: Data, response: HTTPURLResponse) throws -> FixerItem {
        guard response.statusCode == 200, let response = try? JSONDecoder().decode(FixerItem.self, from: data) else {
            throw NetworkError.undecodableData
        }
        return response
    }
}
