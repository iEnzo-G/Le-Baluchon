//
//  WeatherLoader.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 01/09/2022.
//

import Foundation

final class WeatherLoader {
    
    let client: URLSessionHTTPClient
    
    init(client: URLSessionHTTPClient = .init()) {
        self.client = client
    }
    
    func load(cities: [Int], completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let baseURL = URL(string: "http://api.openweathermap.org/data/2.5")!
        let url = WeatherEndpoint.get(cities).url(baseURL: baseURL)
        client.get(url: url) { [weak self] result in
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
                print(error.localizedDescription)
                return
            }
        }
    }
}
