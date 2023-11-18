import UIKit

struct LandingScreens {
    func createLandingViewController(
        currentCity: String,
        didTapForecastButton: ((_ city: String) -> Void)?,
        didTapFavoritesButton: (() -> Void)?
    ) -> UIViewController {
        let viewModel = LandingViewModel(
            didTapForecastButton: didTapForecastButton,
            didTapFavoritesButton: didTapFavoritesButton,
            apiManager: ApiManager(),
            currentCity: currentCity
        )
        return LandingViewController(viewModel: viewModel)
    }
}
