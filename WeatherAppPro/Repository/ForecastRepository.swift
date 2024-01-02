import Foundation

struct ForecastEndpoint: EndpointType {
    var path: String = "https://api.openweathermap.org/data/2.5/forecast?units=metric&cnt=5&appid=79b3683f2a693bab81b3a7c8731ab2ae&q="
    var method: HTTPMethod = .GET

    init(cityName: String) {
        path.append(cityName)
    }
}

protocol ForecastRepositoryType {
    func getForecast(for cityName: String) async throws -> [WeatherModel]
    func clearCache()
}

final class ForecastRepository: ForecastRepositoryType {
    private var cachedForecasts: [String: [WeatherModel]] = [:]

    func clearCache() {
        cachedForecasts = [:]
    }
    
    func refreshCache() {
        for forecast in cachedForecasts {
            guard let date = forecast.value[0].date else { return }
            // If forecast is more than 10 minutes old, we need a new one.
            if (date + TimeInterval(600)) < Date.now {
                cachedForecasts.removeValue(forKey: forecast.key)
                print("deleted \(forecast.value[0].cityName) from cache")
            }
        }
    }

    func getForecast(for cityName: String) async throws -> [WeatherModel] {
        refreshCache()
        switch cachedForecasts[cityName] {
        case .none:
            // Endpoint
            let endpoint = ForecastEndpoint(cityName: cityName)

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
                let forecastResponse = try decode(into: ForecastResponse.self, data: data)
                let forecast = WeatherModel.makeForecast(from: forecastResponse)
                cachedForecasts[forecast[0].cityName] = forecast

                return forecast
            } catch {
                // 🚨 Handle decoding error
                throw DecodeError.cannotDecodeData
            }

        case let .some(forecast):
            return forecast
        }
    }
}
