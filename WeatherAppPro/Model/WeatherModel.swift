import Foundation

struct WeatherModel {
    let cityName: String
    let temperature: Float
    let icon: String
    
    var temperatureString: String {
        String(format: "%.1f", temperature) + "°C"
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
