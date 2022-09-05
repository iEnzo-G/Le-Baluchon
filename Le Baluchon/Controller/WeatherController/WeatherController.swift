//
//  WeatherController.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 01/09/2022.
//


import UIKit

class WeatherController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var citySwipButton: UISegmentedControl!
    @IBOutlet weak var unitTemperatureButton: UIButton!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    // MARK: - Properties
    
    private let weather = WeatherModel()
    private var idWeather: String = ""
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weather.delegate = self
        citySwipButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        weather.getDate("America/New_York")
        weather.getWeather(city: 0)
    }
    
    // MARK: - Actions
    
    @IBAction func tappedCitySwipButton(_ sender: UISegmentedControl) {
        cityNameLabel.text = citySwipButton.selectedSegmentIndex == 0 ? "New York" : "Paris"
        citySwipButton.selectedSegmentIndex == 0 ? weather.getWeather(city: 0) : weather.getWeather(city: 1)
        citySwipButton.selectedSegmentIndex == 0 ? weather.getDate("America/New_York") : weather.getDate("Europe/Paris")
    }
    
    @IBAction func tappedUnitTemperatureButton(_ sender: UIButton) {
        if unitTemperatureButton.title(for: .normal) == "°C" {
            unitTemperatureButton.setTitle("°F", for: .normal)
            weather.url = weather.changeSystem(systeme: "imperial")
        } else {
            unitTemperatureButton.setTitle("°C", for: .normal)
            weather.url = weather.changeSystem(systeme: "metric")
        }
        citySwipButton.selectedSegmentIndex == 0 ? weather.getWeather(city: 0) : weather.getWeather(city: 1)
    }
}

// MARK: - Extension

extension WeatherController: UpdateWeatherDelegate {
    func updateDate(date: String) {
        timeLabel.text = date
    }
    
    func updateWeatherImageView(icon: String) {
        detectWeatherImage(imageView: weatherImageView, idWeather: icon)
    }
    
    func throwAlert(message: String) {
        presentAlert(message: message)
    }
    
    func updateHumidityLabel(humidity: String) {
        humidityLabel.text = humidity
    }
    
    func updateWindLabel(wind: String) {
        windLabel.text = wind
    }
    
    func updateTempLabel(temp: String) {
        tempLabel.text = temp
    }
    
    func updateTempMinLabel(tempMin: String) {
        tempMinLabel.text = tempMin
    }
    
    func updateTempMaxLabel(tempMax: String) {
        tempMaxLabel.text = tempMax
    }
    
    func updateWeatherDescriptionLabel(weatherDescription: String) {
        weatherDescriptionLabel.text = weatherDescription
    }
    
    
}
