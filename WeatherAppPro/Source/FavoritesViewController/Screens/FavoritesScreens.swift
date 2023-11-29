import UIKit
import SwiftUI

struct FavoritesScreens {
    func createFavoritesViewController(
        didTapCell: ((String) -> Void)?,
        currentWeather: WeatherModel
    ) -> UIViewController {
        let viewModel = FavoritesViewModel(favorites: Favorites())
        let vc = FavoritesViewController(
            viewModel: viewModel,
            didTapCell: didTapCell,
            currentWeather: currentWeather
        )
        return vc
    }
    
    func createFavoritesVCSUI(
        didTapCell: ((String) -> Void)?,
        currentWeather: WeatherModel
    ) -> any View {
        let viewModel = FavoritesViewModel(favorites: Favorites())
        let vc = FavoritesVCSUI(
            didTapCell: didTapCell,
            viewModel: viewModel
        )
        return vc
    }
}
