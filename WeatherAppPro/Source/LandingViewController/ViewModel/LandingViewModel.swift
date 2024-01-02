final class LandingViewModel {
    
    private let didTapForecastButton: ((WeatherModel) -> Void)?
    private let didTapFavoritesButton: ((((String) -> Void)?, WeatherModel) -> Void)?
    
    private let repository: CurrentWeatherRepositoryType
    private var favoriteCities: FavoritesType
    private var locationManager: LocationManagerType

    var currentWeather: WeatherModel {
        didSet {
            didChangeCity?(checkIfFavorite())
        }
    }
    
    init(
        didTapForecastButton: ((WeatherModel) -> Void)?,
        didTapFavoritesButton: ((((String) -> Void)?, WeatherModel) -> Void)?,
        repository: CurrentWeatherRepositoryType,
        favoriteCities: FavoritesType,
        locationManager: LocationManagerType,
        currentWeather: WeatherModel
        
    ) {
        self.didTapForecastButton = didTapForecastButton
        self.didTapFavoritesButton = didTapFavoritesButton
        self.repository = repository
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
        Task { @MainActor in
            let weather = try await repository.getCurrentWeather(for: city)
            didReceiveData?(weather[0])
            currentWeather = weather[0]
        }
    }
    
    func onTapLocationButton() {
        locationManager.didReceiveLocation = { location in
            self.onTapLocationSearchButton(lat: location.latitude, lon: location.longitude)
        }
        
        locationManager.requestLocation()
    }
    
    private func onTapLocationSearchButton(lat: Double, lon: Double) {
//        apiManager.fetchCurrentWeather(lat: lat, lon: lon) { [ weak self ] result in
//            switch result {
//            case .success(let weather):
//                guard let self else { return }
//                self.didReceiveData?(weather[0])
//                self.currentWeather = weather[0]
//            case .failure(let error):
//                print("ERROR: \(error)")
//            }
//        }
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
