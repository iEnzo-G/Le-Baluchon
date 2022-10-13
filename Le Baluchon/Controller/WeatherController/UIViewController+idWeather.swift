import UIKit

extension UIViewController {
     
    func detectWeatherImage(imageView: UIImageView, idWeather: String) {
        switch idWeather {
            //day icon
        case "01d": imageView.image = UIImage(systemName: "sun.max")
        case "02d": imageView.image = UIImage(systemName: "cloud.sun")
        case "03d": imageView.image = UIImage(systemName: "cloud")
        case "04d": imageView.image = UIImage(systemName: "cloud")
        case "09d": imageView.image = UIImage(systemName: "cloud.rain")
        case "10d": imageView.image = UIImage(systemName: "cloud.sun.rain")
        case "11d": imageView.image = UIImage(systemName: "cloud.sun.bolt")
        case "13d": imageView.image = UIImage(systemName: "snow")
        case "50d": imageView.image = UIImage(systemName: "cloud.fog")
            //night icon
        case "01n": imageView.image = UIImage(systemName: "moon")
        case "02n": imageView.image = UIImage(systemName: "cloud.moon")
        case "03n": imageView.image = UIImage(systemName: "cloud")
        case "04n": imageView.image = UIImage(systemName: "cloud")
        case "09n": imageView.image = UIImage(systemName: "cloud.rain")
        case "10n": imageView.image = UIImage(systemName: "cloud.moon.rain")
        case "11n": imageView.image = UIImage(systemName: "cloud.moon.bolt")
        case "13n": imageView.image = UIImage(systemName: "snow")
        case "50n": imageView.image = UIImage(systemName: "cloud.fog")
        default: break
        }
    }
}
