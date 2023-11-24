import UIKit

struct FavoritesScreens {
    func createFavoritesViewController(
        didTapCell: ((String) -> Void)?,
        weatherType: WeatherType?
    ) -> UIViewController {
        let viewModel = FavoritesViewModel()
        let vc = FavoritesViewController(
            viewModel: viewModel,
            didTapCell: didTapCell,
            weatherType: weatherType
        )
        return vc
    }
}
