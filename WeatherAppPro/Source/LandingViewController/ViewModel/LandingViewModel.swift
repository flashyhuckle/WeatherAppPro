final class LandingViewModel {
    
    private let didTapForecastButton: ((WeatherModel) -> Void)?
    private let didTapFavoritesButton: ((((String) -> Void)?, WeatherModel) -> Void)?
    
    private let apiManager: ApiManagerInterface
    private var favoriteCities: FavoritesType
    private var locationManager: LocationManagerType
    
    private var cachedCities: [String: WeatherModel] = [:]

    var currentWeather: WeatherModel {
        didSet {
            didChangeCity?(checkIfFavorite())
        }
    }
    
    init(
        didTapForecastButton: ((WeatherModel) -> Void)?,
        didTapFavoritesButton: ((((String) -> Void)?, WeatherModel) -> Void)?,
        apiManager: ApiManagerInterface,
        favoriteCities: FavoritesType,
        locationManager: LocationManagerType,
        currentWeather: WeatherModel
        
    ) {
        self.didTapForecastButton = didTapForecastButton
        self.didTapFavoritesButton = didTapFavoritesButton
        self.apiManager = apiManager
        self.favoriteCities = favoriteCities
        self.locationManager = locationManager
        self.currentWeather = currentWeather
    }
    
    var didReceiveData: ((WeatherModel) -> Void)?
    var didChangeCity: ((Bool) -> Void)?
    
    func viewDidLoad() {
        searchByCity(city: currentWeather.cityName)
    }
    
    func searchBy(cityName city: String) {
        searchByCity(city: city)
    }
    
    private func searchByCity(city: String) {
        switch cachedCities[city] {
        case .none:
            apiManager.fetchCurrentWeather(for: city) { [ weak self ] result in
                switch result {
                case .success(let weather):
                    guard let self else { return }
                    self.cachedCities[city] = weather
                    self.didReceiveData?(weather)
                    self.currentWeather = weather

                case .failure(let error):
                    print("ERROR: \(error)")
                }
            }
        case .some(let cityWeather):
            didReceiveData?(cityWeather)
            currentWeather = cityWeather
        }
    }
    
    func onTapLocationButton() {
        locationManager.didReceiveLocation = { location in
            self.onTapLocationSearchButton(lat: location.latitude, lon: location.longitude)
        }
        
        locationManager.requestLocation()
    }
    
    private func onTapLocationSearchButton(lat: Double, lon: Double) {
        apiManager.fetchCurrentWeather(lat: lat, lon: lon) { [ weak self ] result in
            switch result {
            case .success(let weather):
                guard let self else { return }
                self.didReceiveData?(weather)
                self.currentWeather = weather
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
    
    func onTapFavoriteBarButton() {
        favoriteCities.buttonTapped(currentWeather.cityName)
        didChangeCity?(checkIfFavorite())
    }
    
    private func checkIfFavorite() -> Bool {
        favoriteCities.contains(currentWeather.cityName)
    }

    func onTapForecastButton() {
        didTapForecastButton?(currentWeather)
    }
    
    func onTapFavoritesButton() {
        didTapFavoritesButton?(refresh, currentWeather)
    }

    private func refresh(with cityName: String) {
        searchByCity(city: cityName)
    }
}
