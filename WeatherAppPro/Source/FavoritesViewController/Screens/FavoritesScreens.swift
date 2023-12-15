import UIKit
import SwiftUI

struct FavoritesScreens {
    func createFavoritesViewController(
        didTapCell: ((String) -> Void)?,
        currentWeather: WeatherModel
    ) -> UIViewController {
        let viewModel = FavoritesViewModel(
            favorites: Favorites(),
            didTapCell: didTapCell,
            currentWeather: currentWeather
        )
        let vc = FavoritesViewController(
            viewModel: viewModel
        )
        return vc
    }
}
