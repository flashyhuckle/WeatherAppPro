import UIKit

struct FavoritesCoordinator: CoordinatorType {
    
    //MARK: Properties
    private let screens: FavoritesScreens = FavoritesScreens()
    private let presenter: UINavigationController
    private let didTapCell: ((String) -> Void)?
    private let weatherType: WeatherType?
    
    //MARK: Init
    init(presenter: UINavigationController,
         didTapCell: ((String) -> Void)?,
         weatherType: WeatherType?
    ) {
        self.presenter = presenter
        self.didTapCell = didTapCell
        self.weatherType = weatherType
    }
    //MARK: Start
    func start() {
        let favoritesViewController = screens.createFavoritesViewController(
            didTapCell: didTapCell,
            weatherType: weatherType
        )
        presenter.pushViewController(favoritesViewController, animated: true)
    }
}
