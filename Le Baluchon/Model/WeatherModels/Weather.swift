//
//  Weather.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 01/09/2022.
//

import Foundation


final class WeatherModel {
    
    //MARK: - Properties
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEEE, MMM d - HH:mm"
        return dateFormatter
    }()
    
    private var humidity: Int = 47 {
        didSet {
//            guard let humidityFormatter = formatter.string(for: humidity) else { return }
//            delegate?.updateHumidityLabel(humidity: "Humidity: " + humidityFormatter + " %")
        }
    }
    private var wind: Double = 2.0 {
        didSet {
//            guard let windFormatter = formatter.string(for: wind) else { return }
//            delegate?.updateWindLabel(wind: "Wind: " + windFormatter + unitSpeed)
        }
    }
    private var temp: Double = 68.0 {
        didSet {
//            guard let tempFormatter = formatter.string(for: temp) else { return }
//            delegate?.updateTempLabel(temp: tempFormatter)
        }
    }
    private var tempMin: Double = 68.0 {
        didSet {
//            guard let tempMinFormatter = formatter.string(for: tempMin) else { return }
//            delegate?.updateTempMinLabel(tempMin: "Temp min: " + tempMinFormatter + unitTemp)
        }
    }
    private var tempMax: Double = 70.0 {
        didSet {
//            guard let tempMaxFormatter = formatter.string(for: tempMax) else { return }
//            delegate?.updateTempMaxLabel(tempMax: "Temp max: " + tempMaxFormatter + unitTemp)
        }
    }
    private var weatherDescription: String = "Clear sky" {
        didSet {
//            delegate?.updateWeatherDescriptionLabel(weatherDescription: weatherDescription.capitalized)
        }
    }
    private var icon: String = "01d" {
        didSet {
//            delegate?.updateWeatherImageView(icon: icon)
        }
    }
    
    private var date: String = "Monday, Sep 5 - 09:23" {
        didSet {
//            delegate?.updateDate(date: date.capitalized)
        }
    }
    
    //MARK: - Service
    
    private let service = WeatherLoader()
    private var unitTemp: String = " °F"
    private var unitSpeed: String = " mph"
    var url = URL(string: "http://api.openweathermap.org/data/2.5/group?id=5128581,2968815&units=imperial&apikey=5f51225038fc1ca49b43a55ceb15d459")!
    

// MARK: - Functions
    
    func changeSystem(systeme: String) -> URL {
        unitSpeed = systeme == "imperial" ? " mph" : " m/s"
        unitTemp = systeme == "imperial" ? " °F" : " °C"
        
        let url = URL(string: "http://api.openweathermap.org/data/2.5/group?id=5128581,2968815&units=" + systeme + "&apikey=5f51225038fc1ca49b43a55ceb15d459")!
        return url
    }
    
    func getWeather(cityIndex: Int) {
//        service.load(url: url) { [weak self] result in
//            switch result {
//            case let .success(data):
//                print(data) 
//                self?.getInfo(city: cityIndex, response: data)
//            case let .failure(error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
    func getInfo(cityIndex: Int, response: WeatherResponse) {
        wind = response.list[cityIndex].wind.speed
        humidity = response.list[cityIndex].main.humidity
        temp = response.list[cityIndex].main.temp
        tempMin = response.list[cityIndex].main.tempMin
        tempMax = response.list[cityIndex].main.tempMax
        weatherDescription = response.list[cityIndex].weather[0].description
        icon = response.list[cityIndex].weather[0].icon
    }
    
    func getDate(_ timezone: String) {
        let getDate = Date()
        dateFormatter.timeZone = TimeZone(identifier: timezone)
        date = dateFormatter.string(from: getDate)
    }
}
