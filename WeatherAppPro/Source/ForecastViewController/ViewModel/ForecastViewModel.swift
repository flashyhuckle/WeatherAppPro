import Foundation

final class ForecastViewModel {
    
    private let repository: ForecastRepositoryType
    let currentWeather: WeatherModel
    
    init(
        repository: ForecastRepositoryType,
        currentWeather: WeatherModel
    ) {
        self.repository = repository
        self.currentWeather = currentWeather
    }
    
    var didReceiveData: (([WeatherModel]) -> Void)?
    
    func viewDidLoad() {
//        apiManager.fetchForecastWeather(city: currentWeather.cityName) { [ weak self ] result in
//            switch result {
//            case .success(let weather):
//                guard let self else { return }
//                self.didReceiveData?(weather)
//
//            case .failure(let error):
//                print("ERROR: \(error)")
//            }
//        }
        Task { @MainActor in
            let forecast = try await repository.getForecast(for: currentWeather.cityName)
            didReceiveData?(forecast)
        }
    }
}
