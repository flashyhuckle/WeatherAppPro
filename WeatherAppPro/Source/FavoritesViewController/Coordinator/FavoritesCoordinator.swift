import UIKit

struct FavoritesCoordinator: CoordinatorType {
    
    //MARK: Properties
    private let screens: FavoritesScreens = FavoritesScreens()
    private let presenter: UINavigationController
    private let didTapCell: ((String) -> Void)?
    
    //MARK: Init
    init(presenter: UINavigationController,
         didTapCell: ((String) -> Void)?
    ) {
        self.presenter = presenter
        self.didTapCell = didTapCell
    }
    //MARK: Start
    func start() {
        let favoritesViewController = screens.createFavoritesViewController(didTapCell: didTapCell)
        presenter.pushViewController(favoritesViewController, animated: true)
    }
}
