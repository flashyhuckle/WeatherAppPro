import Foundation
import UIKit

protocol ApiManagerInterface {
    func fetchWeather(
        city: String,
        forecast: Bool,
        onCompletion: @escaping ((Swift.Result<[WeatherModel], Error>) -> Void)
    )
    
    func fetchWeather(
        lat: Double,
        lon: Double,
        forecast: Bool,
        onCompletion: @escaping ((Swift.Result<[WeatherModel], Error>) -> Void)
    )
}

struct ApiManager: ApiManagerInterface {
    private let forecastAPIURL = "https://api.openweathermap.org/data/2.5/forecast?units=metric&cnt=5&appid=79b3683f2a693bab81b3a7c8731ab2ae"
    private let currentAPIURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=79b3683f2a693bab81b3a7c8731ab2ae"
    
    func fetchWeather(
        city: String,
        forecast: Bool,
        onCompletion: @escaping ((Swift.Result<[WeatherModel], Error>) -> Void)
    ) {
        var baseURL = currentAPIURL
        if forecast {
            baseURL = forecastAPIURL
        }
        let urlString = baseURL + "&q=" + city
        performRequest(with: urlString, forecast: forecast) { result in
            onCompletion(result)
        }
    }
    
    func fetchWeather(
        lat: Double,
        lon: Double,
        forecast: Bool,
        onCompletion: @escaping ((Swift.Result<[WeatherModel], Error>) -> Void)
    ) {
        var baseURL = currentAPIURL
        if forecast {
            baseURL = forecastAPIURL
        }
        let urlString = baseURL + "&lat=" + String(lat) + "&lon=" + String(lon)
        performRequest(with: urlString, forecast: forecast) { result in
            onCompletion(result)
        }
    }
    
    private func performRequest(
        with urlString: String,
        forecast: Bool,
        onCompletion: @escaping ((Swift.Result<[WeatherModel], Error>) -> Void)
    ) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        if forecast {
                            let decodedData = try JSONDecoder().decode(ForecastResponse.self, from: data)
                            var weather = [WeatherModel]()
                            for i in 0..<decodedData.cnt {
                                let cityName = decodedData.city.name
                                let temperature = decodedData.list[i].main.temp_max
                                let icon = decodedData.list[i].weather[0].icon
                                weather.append(WeatherModel(cityName: cityName, temperature: temperature, icon: icon))
                            }
    
                            DispatchQueue.main.async {
                                onCompletion(.success(weather))
                            }
                        } else {
                            let decodedData = try JSONDecoder().decode(CurrentResponse.self, from: data)
                            let cityName = decodedData.name
                            let temperature = decodedData.main.temp
                            let icon = decodedData.weather[0].icon
                            let weather = [WeatherModel(cityName: cityName, temperature: temperature, icon: icon)]
                            
                            DispatchQueue.main.async {
                                onCompletion(.success(weather))
                            }
                        }
                    } catch {
                        DispatchQueue.main.async {
                            onCompletion(.failure(error))
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
