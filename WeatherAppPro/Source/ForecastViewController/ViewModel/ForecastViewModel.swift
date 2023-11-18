import Foundation

final class ForecastViewModel {
    
    private let city: String
    private let apiManager: ApiManagerInterface
    
    init(
        city: String,
        apiManager: ApiManagerInterface
    ) {
        self.city = city
        self.apiManager = apiManager
    }
    
    var didReceiveData: (([WeatherModel]) -> Void)?
    
    func viewDidLoad() {
        apiManager.fetchWeather(city: city, forecast: true) { [ weak self ] result in
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
