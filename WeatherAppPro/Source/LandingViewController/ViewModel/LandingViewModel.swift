import SwiftUI

final class LandingViewModel {
    
    private let didTapForecastButton: ((WeatherModel) -> Void)?
    private let didTapFavoritesButton: ((((String) -> Void)?, WeatherModel) -> Void)?
    private let didTapUIButton: ((LandingViewModel) -> Void)?
    
    private let apiManager: ApiManagerInterface
    private var favoriteCities: Favorites
    private var locationManager: LocationManager
    
    var currentWeather: WeatherModel {
        didSet {
            didChangeCity?(checkIfFavorite())
        }
    }
    
    init(
        didTapForecastButton: ((WeatherModel) -> Void)?,
        didTapFavoritesButton: ((((String) -> Void)?, WeatherModel) -> Void)?,
        didTapUIButton: ((LandingViewModel) -> Void)?,
        apiManager: ApiManagerInterface,
        favoriteCities: Favorites,
        locationManager: LocationManager,
        currentWeather: WeatherModel
        
    ) {
        self.didTapForecastButton = didTapForecastButton
        self.didTapFavoritesButton = didTapFavoritesButton
        self.didTapUIButton = didTapUIButton
        self.apiManager = apiManager
        self.favoriteCities = favoriteCities
        self.locationManager = locationManager
        self.currentWeather = currentWeather
    }
    
    var didReceiveData: (([WeatherModel]) -> Void)?
    var didChangeCity: ((Bool) -> Void)?
    
    func viewDidLoad() {
        searchByCity(city: currentWeather.cityName)
        didChangeCity?(checkIfFavorite())
    }
    
    func searchBy(cityName city: String) {
        searchByCity(city: city)
    }
    
    private func searchByCity(city: String) {
        //FIX zmienić warunek istnienia daty na warunek "świeżości"
        if currentWeather.date != nil {
            if city == currentWeather.cityName {
                didReceiveData?([currentWeather])
                return
            }
        }
        apiManager.fetchWeather(city: city, forecast: false) { [ weak self ] result in
            switch result {
            case .success(let weather):
                guard let self else { return }
                self.didReceiveData?(weather)
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
                self.currentWeather = weather[0]
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
    
    func onTapFavoriteBarButton() {
        favoriteCities.buttonTapped(currentWeather.cityName)
        didChangeCity?(checkIfFavorite())
    }
    
    func checkIfFavorite() -> Bool {
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
    
    func UIButtonPressed() {
        didTapUIButton?(self)
    }
}
