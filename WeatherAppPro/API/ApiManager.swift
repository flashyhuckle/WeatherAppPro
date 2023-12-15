import UIKit

protocol ApiManagerInterface {
    func fetchCurrentWeather(
        for city: String,
        onCompletion: @escaping ((Swift.Result<WeatherModel, Error>) -> Void)
    )
    func fetchCurrentWeather(
        lat: Double,
        lon: Double,
        onCompletion: @escaping ((Swift.Result<WeatherModel, Error>) -> Void)
    )
    func fetchForecastWeather(
        city: String,
        onCompletion: @escaping ((Swift.Result<[WeatherModel], Error>) -> Void)
    )
}

enum HTTPRequestError: Error {
    case cannotBuildValidURL(baseURLPath: String, path: String)
}

struct WeatherURLCreator {
    private let forecastAPIURL = "https://api.openweathermap.org/data/2.5/forecast?units=metric&cnt=5&appid=79b3683f2a693bab81b3a7c8731ab2ae"
    private let currentAPIURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=79b3683f2a693bab81b3a7c8731ab2ae"
    
    func createCurrentWeatherURL(for city: String) throws -> URL {
        let urlString = currentAPIURL + "&q=" + city
        let urlStrin = ""
        guard let url = URL(string: urlString) else {
            throw HTTPRequestError.cannotBuildValidURL(baseURLPath: currentAPIURL, path: city)
        }
        return url
    }
    
    func createCurrentWeatherURL(lat: Double, lon: Double) throws -> URL {
        let urlString = currentAPIURL + "&lat=" + String(lat) + "&lon=" + String(lon)
        guard let url = URL(string: urlString) else {
            throw HTTPRequestError.cannotBuildValidURL(baseURLPath: currentAPIURL, path: ("&lat=" + String(lat) + "&lon=" + String(lon)))
        }
        return url
    }
    
    func createForecastURL(for city: String) throws -> URL {
        let urlString = forecastAPIURL + "&q=" + city
        guard let url = URL(string: urlString) else {
            throw HTTPRequestError.cannotBuildValidURL(baseURLPath: forecastAPIURL, path: city)
        }
        return url
    }
}

struct RequestPerformer {
    func performCurrentWeatherRequest(
        url: URL,
        onCompletion: @escaping ((Result<WeatherModel, Error>) -> Void)
    ) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(CurrentResponse.self, from: data)
                    let weather: WeatherModel = WeatherModel.makeCurrent(from: decodedData)
                    DispatchQueue.main.async {
                        onCompletion(.success(weather))
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
    
    
    func performForecastRequest(
        url: URL,
        onCompletion: @escaping ((Result<[WeatherModel], Error>) -> Void)
    ) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(ForecastResponse.self, from: data)
                    let weather: [WeatherModel] = WeatherModel.makeForecast(from: decodedData)
                    DispatchQueue.main.async {
                        onCompletion(.success(weather))
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

struct ApiManager: ApiManagerInterface {
    private let urlCreator: WeatherURLCreator
    private let requestPerformer: RequestPerformer
    
    init(urlCreator: WeatherURLCreator, requestPerformer: RequestPerformer) {
        self.urlCreator = urlCreator
        self.requestPerformer = requestPerformer
    }
    
    func fetchCurrentWeather(
        for city: String,
        onCompletion: @escaping ((Result<WeatherModel, Error>) -> Void)
    ) {
        do {
            let url = try urlCreator.createCurrentWeatherURL(for: city)
            requestPerformer.performCurrentWeatherRequest(
                url: url
            ) { result in
                onCompletion(result)
            }
        } catch let error as HTTPRequestError {
            switch error {
            case let .cannotBuildValidURL(baseURLPath, path):
                print("Wrong URL | baseURLPath: \(baseURLPath) | path: \(path)")
            }
        } catch {
            print("Unknown error: \(error.localizedDescription)")
        }
    }
    
    func fetchCurrentWeather(
        lat: Double,
        lon: Double,
        onCompletion: @escaping ((Result<WeatherModel, Error>) -> Void)
    ) {
        do {
            let url = try urlCreator.createCurrentWeatherURL(lat: lat, lon: lon)
            requestPerformer.performCurrentWeatherRequest(url: url) { result in
                onCompletion(result)
            }
        } catch let error as HTTPRequestError {
            switch error {
            case let .cannotBuildValidURL(baseURLPath, path):
                print("Wrong URL | baseURLPath: \(baseURLPath) | path: \(path)")
            }
        } catch {
            print("Unknown error: \(error.localizedDescription)")
        }
        
    }
    
    func fetchForecastWeather(
        city: String,
        onCompletion: @escaping ((Result<[WeatherModel], Error>) -> Void)
    ) {
        do {
            let url = try urlCreator.createForecastURL(for: city)
            requestPerformer.performForecastRequest(
                url: url
            ) { result in
                onCompletion(result)
            }
        } catch let error as HTTPRequestError {
            switch error {
            case let .cannotBuildValidURL(baseURLPath, path):
                print("Wrong URL | baseURLPath: \(baseURLPath) | path: \(path)")
            }
        } catch {
            print("Unknown error: \(error.localizedDescription)")
        }
    }
    
    func fetchCurrentWeather2(
        for city: String,
        onCompletion: @escaping ((Result<WeatherModel, Error>) -> Void)
    ) {
        do {
            let url = try urlCreator.createCurrentWeatherURL(for: city)
            RequestPerformerPro().performRequest(
                url: url,
                fromType: CurrentResponse.self,
                toType: WeatherModel.self
            ) { currentResponse in
                WeatherModel.makeCurrent(from: currentResponse)
                } onCompletion: { result in
                    onCompletion(result)
                }

        } catch let error as HTTPRequestError {
            switch error {
            case let .cannotBuildValidURL(baseURLPath, path):
                print("Wrong URL | baseURLPath: \(baseURLPath) | path: \(path)")
            }
        } catch {
            print("Unknown error: \(error.localizedDescription)")
        }
    }
}
