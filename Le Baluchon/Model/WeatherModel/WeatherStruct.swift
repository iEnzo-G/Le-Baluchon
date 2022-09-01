//
//  Weather.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 01/09/2022.
//
import Foundation

    // MARK: - Struct for OpenWeather API

struct WeatherResponse: Decodable {
    let cnt: Int
    let list: [List]
}

struct List: Decodable {
    let coord: Coord
    let sys: Sys
    let weather: [Weather]
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt, id: Int
    let name: String
}

struct Clouds: Decodable {
    let all: Int
}

struct Coord: Decodable {
    let lon, lat: Double
}

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

struct Sys: Decodable {
    let country: String
    let timezone, sunrise, sunset: Int
}

struct Weather: Decodable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
}
