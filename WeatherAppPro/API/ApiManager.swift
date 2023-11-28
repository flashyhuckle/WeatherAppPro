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
//        print(urlString)
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        if forecast {
                            let decodedData = try JSONDecoder().decode(ForecastResponse.self, from: data)
                            var weather = [WeatherModel]()
                            for i in 0..<decodedData.cnt {
//                                let cityName = decodedData.city.name
//                                let temperature = decodedData.list[i].main.temp
//                                let maxTemperature = decodedData.list[i].main.temp_max
//                                let minTemperature = decodedData.list[i].main.temp_min
//                                let icon = decodedData.list[i].weather[0].icon
//                                let country = decodedData.city.country
//                                let date = Date(timeInterval: TimeInterval(((i+1) * 86400)), since: Date())
//                                let description = decodedData.list[i].weather[0].description
//                                let sunrise = decodedData.city.sunrise
//                                let sunset = decodedData.city.sunset
//                                let pressure = decodedData.list[i].main.pressure ?? 0
//                                let windSpeed = decodedData.list[i].wind.speed
                                weather.append(WeatherModel(
                                    cityName: decodedData.city.name,
                                    country: decodedData.city.country,
                                    date: Date(timeInterval: TimeInterval(((i+1) * 86400)), since: Date()),
                                    temperature: decodedData.list[i].main.temp,
                                    maxTemperature: decodedData.list[i].main.temp_max,
                                    minTemperature: decodedData.list[i].main.temp_min,
                                    icon: decodedData.list[i].weather[0].icon,
                                    description: decodedData.list[i].weather[0].description,
                                    sunrise: decodedData.city.sunrise,
                                    sunset: decodedData.city.sunset,
                                    pressure: decodedData.list[i].main.pressure ?? 0,
                                    windSpeed: decodedData.list[i].wind.speed
                                ))
                            }
    
                            DispatchQueue.main.async {
                                onCompletion(.success(weather))
                            }
                        } else {
                            let decodedData = try JSONDecoder().decode(CurrentResponse.self, from: data)
                            let cityName = decodedData.name
                            let temperature = decodedData.main.temp
                            let maxTemperature = decodedData.main.temp_max
                            let minTemperature = decodedData.main.temp_min
                            let icon = decodedData.weather[0].icon
                            let country = decodedData.sys.country
                            let date = Date()
                            let description = decodedData.weather[0].description
                            let sunrise = decodedData.sys.sunrise
                            let sunset = decodedData.sys.sunset
                            let pressure = decodedData.main.pressure
                            let windSpeed = decodedData.wind.speed
                            let weather = [WeatherModel(cityName: cityName, country: country, date: date, temperature: temperature,maxTemperature: maxTemperature, minTemperature: minTemperature, icon: icon, description: description, sunrise: sunrise, sunset: sunset, pressure: pressure, windSpeed: windSpeed)]
                            
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
