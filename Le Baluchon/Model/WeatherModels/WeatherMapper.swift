//
//  WeatherMapper.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 01/09/2022.
//

import Foundation

// The mapper will be use to decode the answer of API
final class WeatherMapper {
    private init() {}
    
    static func map(data: Data, response: HTTPURLResponse) throws -> WeatherItem {
        guard response.statusCode == 200, let response = try? JSONDecoder().decode(WeatherItem.self, from: data) else {
            throw NetworkError.undecodableData
        }
        return response
    }
}

