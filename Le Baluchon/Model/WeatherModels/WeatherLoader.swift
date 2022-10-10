//
//  WeatherLoader.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 01/09/2022.
//

import Foundation

final class WeatherLoader {
    
    let client: HTTPClient
    
    init(client: HTTPClient = URLSessionHTTPClient()) {
        self.client = client
    }
    
    func load(cities: [Int], units: String, completion: @escaping (Result<WeatherItem, Error>) -> Void) {
        let baseURL = URL(string: "http://api.openweathermap.org/data/2.5")!
        let url = WeatherEndpoint.get(cities, units).url(baseURL: baseURL)
        client.get(url: URLRequest(url: url)) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success((data, response)):
                do {
                    let result = try WeatherMapper.map(data: data, response: response)
                    completion(.success(result))
                    return
                }  catch {
                    completion(.failure(error))
                    return
                }
            case let .failure(error):
                completion(.failure(error))
                return
            }
        }
    }
}
