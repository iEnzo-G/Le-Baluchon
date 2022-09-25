//
//  WeatherEndpoint.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 25/09/2022.
//

import Foundation

enum WeatherEndpoint {
    case get([Int], String)
    
    func url(baseURL: URL) -> URL {
        switch self {
        case let .get(cities, units):
            var components = URLComponents()
            
            components.scheme = baseURL.scheme
            components.host = baseURL.host
            components.path = baseURL.path + "/group"
            components.queryItems = [
                URLQueryItem(name: "id", value: "\(cities.map(String.init).joined(separator: ","))"),
                URLQueryItem(name: "units", value: units),
                URLQueryItem(name: "apikey", value: "5f51225038fc1ca49b43a55ceb15d459")
            ]
            
            return components.url!
        }
    }
}
