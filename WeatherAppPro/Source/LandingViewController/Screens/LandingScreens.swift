import UIKit

struct LandingScreens {
    func createLandingViewController(
        currentCity: String,
        didTapForecastButton: ((_ city: String, WeatherType?) -> Void)?,
        didTapFavoritesButton: ((((String) -> Void)?, WeatherType?) -> Void)?,
        didTapSwiftUIButton: ((LandingViewModel) -> Void)?
    ) -> UIViewController {
        let viewModel = LandingViewModel(
            didTapForecastButton: didTapForecastButton,
            didTapFavoritesButton: didTapFavoritesButton,
            didTapSwiftUIButton: didTapSwiftUIButton,
            apiManager: ApiManager(),
            locationManager: LocationManager(),
            currentCity: currentCity
        )
        return LandingViewController(viewModel: viewModel)
    }
    
    func createLandingVCSUI() {
        
    }
}
