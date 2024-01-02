import Foundation

struct CurrentWeatherEndpoint: EndpointType {
    var path: String = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=79b3683f2a693bab81b3a7c8731ab2ae&q="
    var method: HTTPMethod = .GET

    init(cityName: String) {
        path.append(cityName)
    }
}

protocol CurrentWeatherRepositoryType {
    func getCurrentWeather(for cityName: String) async throws -> [WeatherModel]
    func clearCache()
}

final class CurrentWeatherRepository: CurrentWeatherRepositoryType {
    private var cachedWeather: [String: [WeatherModel]] = [:]

    func clearCache() {
        cachedWeather = [:]
    }
    
    func refreshCache() {
        for weather in cachedWeather {
            guard let date = weather.value[0].date else { return }
            // If weather is more than 10 minutes old, we need a new one.
            if (date + TimeInterval(600)) < Date.now {
                cachedWeather.removeValue(forKey: weather.key)
                print("deleted \(weather.value[0].cityName) from cache")
            }
        }
    }

    func getCurrentWeather(for cityName: String) async throws -> [WeatherModel] {
        refreshCache()
        switch cachedWeather[cityName] {
        case .none:
            // Endpoint
            let endpoint = CurrentWeatherEndpoint(cityName: cityName)

            // URL
            guard let url = URL(string: endpoint.path) else {
                // 🚨 Handle base url
                throw HTTPRequestError.cannotBuildValidURL(path: endpoint.path, method: endpoint.method)
            }

            // Request
            var request = URLRequest(url: url)
            request.httpMethod = endpoint.method.rawValue

            // Response
            let (data, _) = try await URLSession.shared.data(for: request)
            
            do {
                let currentWeatherResponse = try decode(into: CurrentResponse.self, data: data)
                let currentWeather = WeatherModel.makeCurrent(from: currentWeatherResponse)
                cachedWeather[currentWeather[0].cityName] = currentWeather

                return currentWeather
            } catch {
                // 🚨 Handle decoding error
                throw DecodeError.cannotDecodeData
            }

        case .some(let currentWeather):
            return currentWeather
        }
    }
}
