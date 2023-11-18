import Foundation

final class LandingViewModel {
    
    private let didTapForecastButton: ((_ city: String) -> Void)?
    private let didTapFavoritesButton: (() -> Void)?
    private var currentCity: String
    private let apiManager: ApiManagerInterface
    private let userDefaults = UserDefaults.standard
    
    init(
        didTapForecastButton: ((_ city: String) -> Void)?,
        didTapFavoritesButton: (() -> Void)?,
        apiManager: ApiManagerInterface,
        currentCity: String
        
    ) {
        self.didTapForecastButton = didTapForecastButton
        self.didTapFavoritesButton = didTapFavoritesButton
        self.apiManager = apiManager
        self.currentCity = currentCity
    }
    
    var didReceiveData: (([WeatherModel]) -> Void)?
    
    func viewDidLoad() {
        searchByCity(city: currentCity)
    }
    
    func viewWillAppear() {
        searchByCity(city: currentCity)
    }
    
    func searchByCity(city: String) {
        currentCity = city
        apiManager.fetchWeather(city: currentCity, forecast: false) { [ weak self ] result in
            switch result {
            case .success(let weather):
                guard let self else { return }
                self.didReceiveData?(weather)

            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
    
    func onTapLocationSearchButton(lat: Double, lon: Double) {
        apiManager.fetchWeather(lat: lat, lon: lon, forecast: false) { [ weak self ] result in
            switch result {
            case .success(let weather):
                guard let self else { return }
                self.didReceiveData?(weather)
                self.currentCity = weather[0].cityName

            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
    
    func onTapFavoriteBarButton() {
//        guard var favorites = userDefaults.array(forKey: "favorites") as? [String] else { return }
        if var favorites = userDefaults.array(forKey: "favorites") as? [String] {
            favorites.append(currentCity)
            userDefaults.set(favorites, forKey: "favorites")
        } else {
            var favorites = [String]()
            favorites.append(currentCity)
            userDefaults.set(favorites, forKey: "favorites")
        }
    }

    func onTapForecastButton() {
        didTapForecastButton?(currentCity)
    }
    
    func onTapFavoritesButton() {
        didTapFavoritesButton?()
    }
}
