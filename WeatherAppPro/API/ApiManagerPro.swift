import UIKit

protocol ApiManagerInterfacePro {
    func fetchCurrentWeather(
        query: QueryItems,
        onCompletion: @escaping ((Swift.Result<[WeatherModel], Error>) -> Void)
    )
//    func fetchCurrentWeather(
//        lat: Double,
//        lon: Double,
//        onCompletion: @escaping ((Swift.Result<WeatherModel, Error>) -> Void)
//    )
    func fetchForecastWeather(
        city: String,
        onCompletion: @escaping ((Swift.Result<[WeatherModel], Error>) -> Void)
    )
}

struct ApiManagerPro: ApiManagerInterfacePro {
    private let urlCreator: WeatherURLCreatorPro
    private let requestPerformer: RequestPerformerPro
    
    init(
        urlCreator: WeatherURLCreatorPro = WeatherURLCreatorPro(),
        requestPerformer: RequestPerformerPro = RequestPerformerPro()
    ) {
        self.urlCreator = urlCreator
        self.requestPerformer = requestPerformer
    }
    
    func fetchCurrentWeather(
        query: QueryItems,
        onCompletion: @escaping ((Result<[WeatherModel], Error>) -> Void)
    ) {
        do {
            let url = try urlCreator.createWeatherURL(weather: .current, query: query)
            requestPerformer.performRequest(
                url: url,
                fromType: CurrentResponse.self,
                toType: [WeatherModel].self
            ) { currentResponse in
                WeatherModel.makeCurrent(from: currentResponse)
                } onCompletion: { result in
                    onCompletion(result)
                }

        } catch let error as HTTPRequestErrorPro {
            switch error {
            case let .cannotBuildValidURL(urlPath):
                print("Wrong URL | URLPath: \(urlPath)")
//            case let .cannotDecodeData(from):
//                print("Cannot decode data: \(from)")
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
            let url = try urlCreator.createWeatherURL(weather: .forecast, query: .city(name: city))
            requestPerformer.performRequest(
                url: url,
                fromType: ForecastResponse.self,
                toType: [WeatherModel].self
            ) { forecastResponse in
                WeatherModel.makeForecast(from: forecastResponse)
                } onCompletion: { result in
                    onCompletion(result)
                }

        } catch let error as HTTPRequestErrorPro {
            switch error {
            case let .cannotBuildValidURL(urlPath):
                print("Wrong URL | URLPath: \(urlPath)")
            }
        } catch {
            print("Unknown error: \(error.localizedDescription)")
        }
    }
    
    func fetchWeather(
        weather: WeatherToURL,
        query: QueryItems,
        onCompletion: @escaping ((Result<[WeatherModel], Error>) -> Void)
    ) {
        do {
            let url = try urlCreator.createWeatherURL(weather: weather, query: query)
            URLSession.shared.request(
                with: url
            ) { result in
                do {
                    switch result {
                    case .success(let data):
                        switch weather {
                        case .current:
                            onCompletion(.success(try WeatherDecoder().decodeCurrent(data: data)))
                        case .forecast:
                            onCompletion(.success(try WeatherDecoder().decodeForecast(data: data)))
                        }
                    case .failure(let error):
                        onCompletion(.failure(error))
                    }
                } catch {
                    print(error)
                }
            }
        } catch let error as HTTPRequestErrorPro {
            switch error {
            case let .cannotBuildValidURL(urlPath):
                print("Wrong URL | URLPath: \(urlPath)")
            }
        } catch {
            print("Unknown error: \(error.localizedDescription)")
        }
    }
}


