//
//  Weather.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 01/09/2022.
//
import Foundation

    // MARK: - Struct for OpenWeather API

struct WeatherItem: Decodable {
    let list: [List]
}

struct List: Decodable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
}

struct Main: Decodable {
    let temp, tempMin, tempMax: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
    }
}

struct Weather: Decodable {
    let description, icon: String
}

struct Wind: Decodable {
    let speed: Double
}
