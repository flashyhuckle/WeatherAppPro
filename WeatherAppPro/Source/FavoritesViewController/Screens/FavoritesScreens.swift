import UIKit

struct FavoritesScreens {
    func createFavoritesViewController(
        didTapCell: ((String) -> Void)?
    ) -> UIViewController {
        let viewModel = FavoritesViewModel()
        let vc = FavoritesViewController(viewModel: viewModel, didTapCell: didTapCell)
        return vc
    }
}
