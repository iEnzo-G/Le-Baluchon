//
//  UpdateWeatherDelegate.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 01/09/2022.
//

import Foundation


// Communicate between Model and Controller
protocol UpdateWeatherDelegate: NSObject {
    func throwAlert(message: String)
    func updateHumidityLabel(humidity: String)
    func updateWindLabel(wind: String)
    func updateTempLabel(temp: String)
    func updateTempMinLabel(tempMin: String)
    func updateTempMaxLabel(tempMax: String)
    func updateWeatherDescriptionLabel(weatherDescription: String)
    func updateWeatherImageView(icon: String)
    func updateDate(date: String)
}
