//
//  Weather.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 01/09/2022.
//

import Foundation


final class WeatherModel {
    
    //MARK: - Properties
    weak var delegate: UpdateWeatherDelegate?
    var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    var humidity: Int = 47 {
        didSet {
            guard let humidityFormatter = formatter.string(for: humidity) else { return }
            delegate?.updateHumidityLabel(humidity: "Humidity: " + humidityFormatter + " %")
        }
    }
    var wind: Double = 2.0 {
        didSet {
            guard let windFormatter = formatter.string(for: wind) else { return }
            delegate?.updateWindLabel(wind: "Wind: " + windFormatter + " mph")
        }
    }
    var temp: Double = 68.0 {
        didSet {
            guard let tempFormatter = formatter.string(for: temp) else { return }
            delegate?.updateTempLabel(temp: tempFormatter)
        }
    }
    var tempMin: Double = 68.0 {
        didSet {
            guard let tempMinFormatter = formatter.string(for: tempMin) else { return }
            delegate?.updateTempMinLabel(tempMin: "Temp min: " + tempMinFormatter + " °F")
        }
    }
    var tempMax: Double = 70.0 {
        didSet {
            guard let tempMaxFormatter = formatter.string(for: tempMax) else { return }
            delegate?.updateTempMaxLabel(tempMax: "Temp max: " + tempMaxFormatter + " °F")
        }
    }
    var weatherDescription: String = "Clear sky" {
        didSet {
            
            delegate?.updateWeatherDescriptionLabel(weatherDescription: weatherDescription.capitalized)
        }
    }
    var icon: String = "01d"
    
    //MARK: - Service
    
    let service = WeatherLoader()
    let url = URL(string: "http://api.openweathermap.org/data/2.5/group?id=5128581,2968815&units=imperial&apikey=5f51225038fc1ca49b43a55ceb15d459")!
    

    
// MARK: - Functions
    
    func getWeather(city: Int) {
        service.load(url: url) { [weak self] result in
            switch result {
            case let .success(data):
                print(data)
                self?.getInfo(city: city, response: data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getInfo(city: Int, response: WeatherResponse) {
        wind = response.list[city].wind.speed
        humidity = response.list[city].main.humidity
        temp = response.list[city].main.temp
        tempMin = response.list[city].main.tempMin
        tempMax = response.list[city].main.tempMax
        weatherDescription = response.list[city].weather[0].weatherDescription
        icon = response.list[city].weather[0].icon
    }
}
