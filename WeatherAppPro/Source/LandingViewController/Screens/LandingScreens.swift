import UIKit
import SwiftUI

struct LandingScreens {
    func createLandingViewController(
        currentWeather: WeatherModel,
        didTapForecastButton: ((WeatherModel) -> Void)?,
        didTapFavoritesButton: ((((String) -> Void)?, WeatherModel) -> Void)?,
        didTapUIButton: ((LandingViewModel) -> Void)?
    ) -> UIViewController {
        let viewModel = LandingViewModel(
            didTapForecastButton: didTapForecastButton,
            didTapFavoritesButton: didTapFavoritesButton,
            didTapUIButton: didTapUIButton,
            apiManager: ApiManager(),
            favoriteCities: Favorites(),
            locationManager: LocationManager(),
            currentWeather: currentWeather
        )
        return LandingViewController(viewModel: viewModel)
    }
    
    func createLandingVCSUI(
        currentWeather: WeatherModel,
        didTapForecastButton: ((WeatherModel) -> Void)?,
        didTapFavoritesButton: ((((String) -> Void)?, WeatherModel) -> Void)?,
        didTapUIButton: ((LandingViewModel) -> Void)?
    ) -> UIViewController {
        let viewModel = LandingViewModel(
            didTapForecastButton: didTapForecastButton,
            didTapFavoritesButton: didTapFavoritesButton,
            didTapUIButton: didTapUIButton,
            apiManager: ApiManager(),
            favoriteCities: Favorites(),
            locationManager: LocationManager(),
            currentWeather: currentWeather
        )
        return UIHostingController(rootView: LandingVCSUI(viewModel: viewModel, currentWeather: currentWeather))
    }
}
