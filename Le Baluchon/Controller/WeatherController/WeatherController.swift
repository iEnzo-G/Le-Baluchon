//
//  WeatherController.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 01/09/2022.
//


import UIKit

final class WeatherController: UIViewController {
    
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
    private let loader = WeatherLoader()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citySwipButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        weather.getDate("America/New_York")
        weather.getWeather(cityIndex: 0)
        
//        loader.load(cities: [5128581, 2968815]) { [weak self] result in
//            switch result {
//            case let .success(response):
//                print(response)
//            case let .failure(error):
//                print(error)
//            }
//        }
    }
    
    // MARK: - Actions
    
    @IBAction func tappedCitySwipButton(_ sender: UISegmentedControl) {
        cityNameLabel.text = citySwipButton.selectedSegmentIndex == 0 ? "New York" : "Paris"
        citySwipButton.selectedSegmentIndex == 0 ? weather.getWeather(cityIndex: 0) : weather.getWeather(cityIndex: 1)
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
        citySwipButton.selectedSegmentIndex == 0 ? weather.getWeather(cityIndex: 0) : weather.getWeather(cityIndex: 1)
    }
}
