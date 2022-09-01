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
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weather.delegate = self
        citySwipButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        weather.getWeather(city: 0)
    }
    
    // MARK: - Actions
    @IBAction func tappedCitySwipButton(_ sender: UISegmentedControl) {
        cityNameLabel.text = citySwipButton.selectedSegmentIndex == 0 ? "New York City" : "Paris"
        citySwipButton.selectedSegmentIndex == 0 ? weather.getWeather(city: 0) : weather.getWeather(city: 1)
    }
    
}

// MARK: - Extension

extension WeatherController: UpdateWeatherDelegate {
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
