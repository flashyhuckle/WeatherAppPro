import Foundation

enum WeatherType {
    case hot
    case warm
    case mild
    case cold
    case freezing
}

struct WeatherModel: Equatable {
    let cityName: String
    let country: String?
    let date: Date?
    let temperature: Float?
    let maxTemperature: Float?
    let minTemperature: Float?
    let icon: String?
    let description: String?
    let sunrise: Int?
    let sunset: Int?
    let pressure: Int?
    let windSpeed: Float?
    
    var descriptionString: String {
        if let description = description {
            return description
        } else {
            return ""
        }
    }
    
    var sunriseString: String {
        if let sunrise = sunrise {
            return Date(timeIntervalSince1970: TimeInterval(sunrise)).formatted(date: .omitted, time: .shortened)
        } else {
            return ""
        }
    }
    
    var sunsetString: String {
        if let sunset = sunset {
            return Date(timeIntervalSince1970: TimeInterval(sunset)).formatted(date: .omitted, time: .shortened)
        } else {
            return ""
        }
    }
    
    var dateString: String {
        if let date = date {
            return date.formatted(Date.FormatStyle().weekday(.wide).month(.wide).day(.twoDigits))
        } else {
            return ""
        }
    }
    
    var shortDateString: String {
        if let date = date {
            return date.formatted(Date.FormatStyle().month(.twoDigits).day(.twoDigits))
        } else {
            return ""
        }
    }
    
    var locationString: String {
        cityName + ", " + (country ?? "")
    }
    
    var temperatureString: String {
        getTemperatureString(from: temperature)
    }
    
    var maxtemperatureString: String {
        getTemperatureString(from: maxTemperature)
    }
    
    var mintemperatureString: String {
        getTemperatureString(from: minTemperature)
    }
    
    private func getTemperatureString(from temperature: Float?) -> String {
        let temp = String(format: "%.0f", temperature ?? 0) + "°"
        if temp == "-0°" {
            return "0°"
        } else {
            return temp
        }
    }
    
    var pressureString: String {
        return String(pressure ?? 0) + "hPa"
    }
    
    var windSpeedString: String {
        String(format: "%.0f", windSpeed ?? 0) + "km/h"
    }
    
    var weatherType: WeatherType {
        switch temperature ?? 0 {
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
    
    static let example = WeatherModel(
        cityName: Constants.baseCity,
        country: nil,
        date: nil,
        temperature: nil,
        maxTemperature: nil,
        minTemperature: nil,
        icon: nil,
        description: nil,
        sunrise: nil,
        sunset: nil,
        pressure: nil,
        windSpeed: nil
    )
}

extension WeatherModel {
    static func makeForecast(
        from model: ForecastResponse
    ) -> [Self] {
        model.list.enumerated().map { index, forecast in
            WeatherModel(
                cityName: model.city.name,
                country: model.city.country,
                date: Date(
                    timeInterval: TimeInterval(((index + 1) * 86400)),
                    since: Date()
                ),
                temperature: forecast.main.temp,
                maxTemperature: forecast.main.temp_max,
                minTemperature: forecast.main.temp_min,
                icon: forecast.weather[0].icon,
                description: forecast.weather[0].description,
                sunrise: model.city.sunrise,
                sunset: model.city.sunset,
                pressure: forecast.main.pressure ?? 0,
                windSpeed: forecast.wind.speed
            )
        }
    }

    static func makeCurrent(
        from model: CurrentResponse
    ) -> Self {
        WeatherModel(
            cityName: model.name,
            country: model.sys.country,
            date: Date(),
            temperature: model.main.temp,
            maxTemperature: model.main.temp_max,
            minTemperature: model.main.temp_min,
            icon: model.weather[0].icon,
            description: model.weather[0].description,
            sunrise: model.sys.sunrise,
            sunset: model.sys.sunset,
            pressure: model.main.pressure,
            windSpeed: model.wind.speed
        )
    }
}
