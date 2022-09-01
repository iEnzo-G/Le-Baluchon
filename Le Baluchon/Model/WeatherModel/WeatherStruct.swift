//
//  Weather.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 01/09/2022.
//
import Foundation

    // MARK: - Struct for OpenWeather API
struct List: Decodable {
    let list: [City]
}

struct City: Decodable {
    let weather: [Weather]
    let main: Main
    let wind: [String: Double]
    let name: String
}

struct Main: Decodable {
    let temp, tempMin, tempMax: Double
    let humidity: Int
}

struct Weather: Decodable {
    let id: Int
    let weatherDescription, icon: String
}
