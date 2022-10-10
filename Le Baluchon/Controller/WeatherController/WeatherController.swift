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
    
    private let loader = WeatherLoader()
    
    private var humidity: Int = 47 {
        didSet {
            guard let humidityFormatter = formatter.string(for: humidity) else { return }
            humidityLabel.text = "Humidity: " + humidityFormatter + " %"
        }
    }
    private var wind: Double = 2.0 {
        didSet {
            guard let windFormatter = formatter.string(for: wind) else { return }
            windLabel.text = "Wind: " + windFormatter + unitSpeed
        }
    }
    private var temp: Double = 68.0 {
        didSet {
            guard let tempFormatter = formatter.string(for: temp) else { return }
            tempLabel.text = tempFormatter
        }
    }
    private var tempMin: Double = 68.0 {
        didSet {
            guard let tempMinFormatter = formatter.string(for: tempMin) else { return }
            tempMinLabel.text = "Temp min: " + tempMinFormatter + unitTemp
        }
    }
    private var tempMax: Double = 70.0 {
        didSet {
            guard let tempMaxFormatter = formatter.string(for: tempMax) else { return }
            tempMaxLabel.text = "Temp max: " + tempMaxFormatter + unitTemp
        }
    }
    private var weatherDescription = "Clear sky" {
        didSet {
            weatherDescriptionLabel.text = weatherDescription.capitalized
        }
    }
    private var date = "Monday, Sep 5 - 09:23" {
        didSet {
            timeLabel.text = date
        }
    }
    
    private var idWeather = "01d" {
        didSet {
            detectWeatherImage(imageView: weatherImageView, idWeather: idWeather)
        }
    }
    private var units = "imperial"
    private var unitSpeed = " mph"
    private var unitTemp = " °F"
    
    // MARK: - Formatters
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "EEEE, MMM d - h:mm a"
        return dateFormatter
    }()
    
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citySwipButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        getDate("America/New_York")
        getWeather(cityIndex: 0)
    }
    
    // MARK: - Actions
    
    @IBAction func tappedCitySwipButton(_ sender: UISegmentedControl) {
        cityNameLabel.text = citySwipButton.selectedSegmentIndex == 0 ? "New York" : "Paris"
        citySwipButton.selectedSegmentIndex == 0 ? getWeather(cityIndex: 0) : getWeather(cityIndex: 1)
        citySwipButton.selectedSegmentIndex == 0 ? getDate("America/New_York") : getDate("Europe/Paris")
    }
    
    @IBAction func tappedUnitTemperatureButton(_ sender: UIButton) {
        if unitTemperatureButton.title(for: .normal) == "°C" {
            unitTemperatureButton.setTitle("°F", for: .normal)
            units = "imperial"
        } else {
            unitTemperatureButton.setTitle("°C", for: .normal)
            units = "metric"
        }
        unitSpeed = units == "imperial" ? " mph" : " m/s"
        unitTemp = units == "imperial" ? " °F" : " °C"
        citySwipButton.selectedSegmentIndex == 0 ? getWeather(cityIndex: 0) : getWeather(cityIndex: 1)
    }
    
    
    private func getDate(_ timezone: String) {
        let getDate = Date()
        dateFormatter.timeZone = TimeZone(identifier: timezone)
        date = dateFormatter.string(from: getDate)
    }
    
    private func getWeather(cityIndex: Int) {
        loader.load(cities: [5128581, 2968815], units: units) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    self?.getInfo(cityIndex: cityIndex, response: data)
                case .failure(_):
                    self?.presentAlert(message: "Something happened wrong from the API. Please try later.")
                }
            }
        }
    }
    
    private func getInfo(cityIndex: Int, response: WeatherItem) {
        wind = response.list[cityIndex].wind.speed
        humidity = response.list[cityIndex].main.humidity
        temp = response.list[cityIndex].main.temp
        tempMin = response.list[cityIndex].main.tempMin
        tempMax = response.list[cityIndex].main.tempMax
        weatherDescription = response.list[cityIndex].weather[0].description
        idWeather = response.list[cityIndex].weather[0].icon
    }
}
