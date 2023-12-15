import Foundation
import XCTest
import CoreLocation
@testable import WeatherAppPro

class LandingViewModelTests: XCTestCase {
    override func setUp() {
        super.setUp()
        
    }
    
    func test_viewDidLoad() {
        let expectedValue = WeatherModel.example
        let viewModel = createViewModel()

        viewModel.didReceiveData = { weather in
            XCTAssertEqual(weather, expectedValue)
        }

        viewModel.viewDidLoad()
    }
    
    func test_onTapForecastButton() {
        let expectedValue = WeatherModel.example
        let testClosure: ((WeatherModel) -> Void)? = { model in
            XCTAssertEqual(model, expectedValue)
        }

        let viewModel = createViewModel(didTapForecastButton: testClosure)

        viewModel.onTapForecastButton()
    }
    
    
    func test_onTapFavoritesButton() {
        let expectedValue = WeatherModel.example
        let testClosure: ((((String) -> Void)?, WeatherModel) -> Void)? = { _, model in
            XCTAssertEqual(model, expectedValue)
        }
        
        let viewModel = createViewModel(didTapFavoritesButton: testClosure)

        viewModel.onTapFavoritesButton()
    }
    
    func test_onTapLocationButton() {
        let expectedValue = WeatherModel.example
        let viewModel = createViewModel()
        
        viewModel.didReceiveData = { weather in
            XCTAssertEqual(weather, expectedValue)
        }

        viewModel.onTapLocationButton()
    }
    
    func test_onTapFavoriteBarButtonLike() {
        let expectedValue = true
        let viewModel = createViewModel()
        
        viewModel.didChangeCity = { bool in
            XCTAssertEqual(bool, expectedValue)
        }

        viewModel.onTapFavoriteBarButton()
    }
    
    func test_onTapFavoriteBarButtonLikeRemove() {
        let expectedValue = false
        let favoritesMock = MockFavorites()
        favoritesMock.favorites.insert(WeatherModel.example.cityName)
        
        let viewModel = createViewModel(favoriteCities: favoritesMock)
        viewModel.didChangeCity = { bool in
            XCTAssertEqual(bool, expectedValue)
        }
        
        viewModel.onTapFavoriteBarButton()
    }

}


private extension LandingViewModelTests {
    func createViewModel(
        didTapForecastButton: ((WeatherModel) -> Void)? = nil,
        didTapFavoritesButton: ((((String) -> Void)?, WeatherModel) -> Void)? = nil,
        apiManager: ApiManagerInterface = MockApiManager(),
        favoriteCities: FavoritesType = MockFavorites(),
        locationManager: LocationManagerType = MockLocationManager(),
        currentWeather: WeatherModel = WeatherModel.example
    ) -> LandingViewModel {
        LandingViewModel(
            didTapForecastButton: didTapForecastButton,
            didTapFavoritesButton: didTapFavoritesButton,
            apiManager: apiManager,
            favoriteCities: favoriteCities,
            locationManager: locationManager,
            currentWeather: currentWeather
        )
    }
}
