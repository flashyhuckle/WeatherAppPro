import Foundation

enum WeatherType {
    case hot
    case warm
    case mild
    case cold
    case freezing
}

struct WeatherModel {
    let cityName: String
    let country: String
    let date: Date
    let temperature: Float
    let maxTemperature: Float
    let minTemperature: Float
    let icon: String
    let description: String
    let sunrise: Int
    let sunset: Int
    let pressure: Int
    let windSpeed: Float
    
    var sunriseString: String {
        return Date(timeIntervalSince1970: TimeInterval(sunrise)).formatted(date: .omitted, time: .shortened)
    }
    
    var sunsetString: String {
        return Date(timeIntervalSince1970: TimeInterval(sunset)).formatted(date: .omitted, time: .shortened)
    }
    
    var temperatureString: String {
        String(format: "%.0f", temperature) + "°"
    }
    
    var maxtemperatureString: String {
        String(format: "%.0f", maxTemperature) + "°"
    }
    
    var mintemperatureString: String {
        String(format: "%.0f", minTemperature) + "°"
    }
    
    var pressureString: String {
        return String(pressure) + "hPa"
    }
    
    var windSpeedString: String {
        String(format: "%.0f", windSpeed) + "km/h"
    }
    
    var weatherType: WeatherType {
        switch temperature {
        case 30... :
            return .hot
        case 20...30 :
            return .warm
        case 10...20 :
            return .mild
        case 0...10 :
            return .cold
        case ...0 :
            return .freezing
        default:
            return .mild
        }
    }
    
    var systemIcon: String {
        switch icon {
        case "01d":
            return "sun.max"
        case "01n":
            return "moon"
        case "02d":
            return "cloud.sun"
        case "02n":
            return "cloud.moon"
        case "03d", "03n":
            return "cloud"
        case "04d", "04n":
            return "cloud"
        case "09d", "09n":
            return "cloud.drizzle"
        case "10d", "10n":
            return "cloud.rain"
        case "11d", "11n":
            return "cloud.bolt.rain"
        case "13d", "13n":
            return "cloud.snow"
        case "50d", "50n":
            return "cloud.fog"
        default:
            return "sun.max.trianglebadge.exclamationmark"
        }
    }
}
