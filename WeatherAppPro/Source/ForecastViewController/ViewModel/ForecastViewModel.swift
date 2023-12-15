import Foundation

final class ForecastViewModel {
    
    private let apiManager: ApiManagerInterface
    let currentWeather: WeatherModel
    
    init(
        apiManager: ApiManagerInterface,
        currentWeather: WeatherModel
    ) {
        self.apiManager = apiManager
        self.currentWeather = currentWeather
    }
    
    var didReceiveData: (([WeatherModel]) -> Void)?
    
    func viewDidLoad() {
        apiManager.fetchForecastWeather(city: currentWeather.cityName) { [ weak self ] result in
            switch result {
            case .success(let weather):
                guard let self else { return }
                self.didReceiveData?(weather)

            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
}
