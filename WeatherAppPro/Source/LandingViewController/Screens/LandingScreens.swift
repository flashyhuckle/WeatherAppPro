import UIKit
import SwiftUI

struct LandingScreens {
    func createLandingViewController(
        currentWeather: WeatherModel,
        didTapForecastButton: ((WeatherModel) -> Void)?,
        didTapFavoritesButton: ((((String) -> Void)?, WeatherModel) -> Void)?
    ) -> UIViewController {
        let viewModel = LandingViewModel(
            didTapForecastButton: didTapForecastButton,
            didTapFavoritesButton: didTapFavoritesButton,
            apiManager: ApiManager(
                urlCreator: WeatherURLCreator(),
                requestPerformer: RequestPerformer()
            ),
            favoriteCities: Favorites(),
            locationManager: LocationManager(),
            currentWeather: currentWeather
        )
        return LandingViewController(viewModel: viewModel)
    }
}
