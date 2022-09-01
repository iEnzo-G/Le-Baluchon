//
//  Weather.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 01/09/2022.
//

import Foundation

// MARK: - Welcome

struct Welcome: Decodable {
    let coord: [String: Double]
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: [String: Int]
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}


// MARK: - Main
struct Main: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Decodable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Decodable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Decodable {
    let speed: Double
    let deg: Int
}


class WeatherModel {
    var longitude = ""
    var latitude = ""
    let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid=5f51225038fc1ca49b43a55ceb15d459")
    
    func newYork() {
        longitude = "-74.005941"
        latitude = "40.712784"
    }
}
