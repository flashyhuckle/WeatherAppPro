import UIKit

protocol ApiManagerInterfacePro {
    func fetchCurrentWeather(
        query: QueryItems,
        onCompletion: @escaping ((Swift.Result<WeatherModel, Error>) -> Void)
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
    
    init(urlCreator: WeatherURLCreatorPro, requestPerformer: RequestPerformerPro) {
        self.urlCreator = urlCreator
        self.requestPerformer = requestPerformer
    }
    
    func fetchCurrentWeather(
        query: QueryItems,
        onCompletion: @escaping ((Result<WeatherModel, Error>) -> Void)
    ) {
        do {
            let url = try urlCreator.createWeatherURL(weather: .current, query: query)
            requestPerformer.performRequest(
                url: url,
                fromType: CurrentResponse.self,
                toType: WeatherModel.self
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
    
//    func fetchCurrentWeather(
//        lat: Double,
//        lon: Double,
//        onCompletion: @escaping ((Result<WeatherModel, Error>) -> Void)
//    ) {
//        do {
//            let url = try urlCreator.createWeatherURL(weather: .current, query: .coordinates(lat: lat, lon: lon))
//            requestPerformer.performRequest(
//                url: url,
//                fromType: CurrentResponse.self,
//                toType: WeatherModel.self
//            ) { currentResponse in
//                WeatherModel.makeCurrent(from: currentResponse)
//                } onCompletion: { result in
//                    onCompletion(result)
//                }
//        } catch let error as HTTPRequestErrorPro {
//            switch error {
//            case let .cannotBuildValidURL(urlPath):
//                print("Wrong URL | URLPath: \(urlPath)")
//            }
//        } catch {
//            print("Unknown error: \(error.localizedDescription)")
//        }
//        
//    }
    
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
    
//    func fetchWeather(
//        weather: WeatherToURL,
//        query: QueryItems,
//        onCompletion: @escaping ((Result<[WeatherModel], Error>) -> Void)
//    ) {
//        do {
//            let url = try urlCreator.createWeatherURL(weather: weather, query: query)
//            requestPerformer.performRequest(
//                url: url,
//                fromType: (weather == .current) ? CurrentResponse.self : ForecastResponse.self,
//                toType: [WeatherModel].self
//            ) { decodableData in
//                    switch weather {
//                    case .current:
//                        [WeatherModel.makeCurrent(from: decodableData)]
//                    case .forecast:
//                        WeatherModel.makeForecast(from: decodableData)
//                    }
//                } onCompletion: { result in
//                    onCompletion(result)
//                }
//
//        } catch let error as HTTPRequestErrorPro {
//            switch error {
//            case let .cannotBuildValidURL(urlPath):
//                print("Wrong URL | URLPath: \(urlPath)")
//            }
//        } catch {
//            print("Unknown error: \(error.localizedDescription)")
//        }
//    }
}


