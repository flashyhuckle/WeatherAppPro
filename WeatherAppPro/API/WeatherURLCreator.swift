import Foundation

enum WeatherToURL: String {
    case current = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=79b3683f2a693bab81b3a7c8731ab2ae"
    case forecast = "https://api.openweathermap.org/data/2.5/forecast?units=metric&cnt=5&appid=79b3683f2a693bab81b3a7c8731ab2ae"
}

enum QueryItems {
    case city(name: String)
    case coordinates(lat: Double, lon: Double)
}

struct WeatherURLCreatorPro {
    
    func createWeatherURL(
        weather: WeatherToURL,
        query: QueryItems
    ) throws -> URL {
        var urlString = weather.rawValue
        
        switch query {
        case .city(let name):
            urlString += "&q=" + name
        case .coordinates(let lat, let lon):
            urlString += "&lat=" + String(lat) + "&lon=" + String(lon)
        }
        
        guard let url = URL(string: urlString) else {
            throw HTTPRequestErrorPro.cannotBuildValidURL(urlPath: urlString)
        }
        return url
    }
}

