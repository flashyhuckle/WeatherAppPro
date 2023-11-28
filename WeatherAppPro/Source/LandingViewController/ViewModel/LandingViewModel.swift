import SwiftUI

final class LandingViewModel {
    
    private let didTapForecastButton: ((_ city: String, WeatherType?) -> Void)?
    private let didTapFavoritesButton: ((((String) -> Void)?, WeatherType?) -> Void)?
    private let didTapSwiftUIButton: ((LandingViewModel) -> Void)?
    private var currentCity: String {
        didSet {
            didChangeCity?(checkIfFavorite())
        }
    }
    private var weatherType: WeatherType?
    private let apiManager: ApiManagerInterface
    private var favoriteCities: Set<String>
    private var locationManager: LocationManager
    
    var currentWeather: WeatherModel?
    
    init(
        didTapForecastButton: ((_ city: String, WeatherType?) -> Void)?,
        didTapFavoritesButton: ((((String) -> Void)?, WeatherType?) -> Void)?,
        didTapSwiftUIButton: ((LandingViewModel) -> Void)?,
        apiManager: ApiManagerInterface,
        locationManager: LocationManager,
        currentCity: String
        
    ) {
        self.didTapForecastButton = didTapForecastButton
        self.didTapFavoritesButton = didTapFavoritesButton
        self.didTapSwiftUIButton = didTapSwiftUIButton
        self.apiManager = apiManager
        self.locationManager = locationManager
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
        if city == currentCity {
            if let currentWeather = currentWeather {
                didReceiveData?([currentWeather])
                return
            }
        }
        
        currentCity = city
        apiManager.fetchWeather(city: currentCity, forecast: false) { [ weak self ] result in
            switch result {
            case .success(let weather):
                guard let self else { return }
                self.didReceiveData?(weather)
                self.weatherType = weather[0].weatherType
                self.currentWeather = weather[0]

            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
    
    func onTapLocationButton() {
        locationManager.didReceiveLocation = { location in
            self.onTapLocationSearchButton(lat: location.latitude, lon: location.longitude)
        }
        
        locationManager.requestLocation()
    }
    
    func onTapLocationSearchButton(lat: Double, lon: Double) {
        apiManager.fetchWeather(lat: lat, lon: lon, forecast: false) { [ weak self ] result in
            switch result {
            case .success(let weather):
                guard let self else { return }
                self.didReceiveData?(weather)
                self.currentCity = weather[0].cityName
                self.weatherType = weather[0].weatherType
                self.currentWeather = weather[0]
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
        didTapForecastButton?(currentCity, weatherType)
    }
    
    func onTapFavoritesButton() {
        didTapFavoritesButton?(refresh, weatherType)
    }

    private func refresh(with cityName: String) {
        searchByCity(city: cityName)
    }
    
    func swiftUIButtonPressed() {
        didTapSwiftUIButton?(self)
//        let view = UIHostingController(rootView: LandingVCSUI(viewModel: self))
//        view.rootView.dismiss = {
//            let landing = LandingCoordinator(presenter: self.presenter!)
//            landing.start()
//        }
//        presenter?.rootViewController = view
//        presenter?.makeKeyAndVisible()
    }
}
