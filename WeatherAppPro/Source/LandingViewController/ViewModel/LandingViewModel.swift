import Foundation

final class LandingViewModel {
    
    private let didTapForecastButton: ((_ city: String) -> Void)?
    private let didTapFavoritesButton: ((((String) -> Void)?) -> Void)?
    private var currentCity: String {
        didSet {
            didChangeCity?(checkIfFavorite())
        }
    }
    private let apiManager: ApiManagerInterface
//    private let userDefaults = UserDefaults.standard
    private var favoriteCities: Set<String>
    
    init(
        didTapForecastButton: ((_ city: String) -> Void)?,
        didTapFavoritesButton: ((((String) -> Void)?) -> Void)?,
        apiManager: ApiManagerInterface,
        currentCity: String
        
    ) {
        self.didTapForecastButton = didTapForecastButton
        self.didTapFavoritesButton = didTapFavoritesButton
        self.apiManager = apiManager
        self.currentCity = currentCity
        
        if let defaults = UserDefaults.standard.object(forKey: "favorites") as? [String] {
            let set = Set(defaults.map({$0}))
            favoriteCities = set
        } else {
            favoriteCities = []
        }
    }
    
    var didReceiveData: (([WeatherModel]) -> Void)?
    var didChangeCity: ((Bool) -> Void)?
    
    func viewDidLoad() {
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
        if checkIfFavorite() {
            favoriteCities.remove(currentCity)
            save()
        } else {
            favoriteCities.insert(currentCity.capitalized(with: nil))
            save()
        }
        didChangeCity?(checkIfFavorite())
    }
    
    private func save() {
        let array = favoriteCities.map {$0}
        UserDefaults.standard.set(array, forKey: "favorites")
    }
    
    func checkIfFavorite() -> Bool {
        if favoriteCities.contains(currentCity.capitalized(with: nil)) {
            return true
        } else {
            return false
        }
    }

    func onTapForecastButton() {
        didTapForecastButton?(currentCity)
    }
    
    func onTapFavoritesButton() {
        didTapFavoritesButton?(refresh)
    }

    func refresh(with cityName: String) {
        searchByCity(city: cityName)
    }
}
