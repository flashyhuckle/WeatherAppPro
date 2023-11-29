import UIKit

struct FavoritesCoordinator: CoordinatorType {
    
    //MARK: Properties
    private let screens: FavoritesScreens = FavoritesScreens()
    private let presenter: UINavigationController
    private let didTapCell: ((String) -> Void)?
    private let currentWeather: WeatherModel
    
    //MARK: Init
    init(presenter: UINavigationController,
         didTapCell: ((String) -> Void)?,
         currentWeather: WeatherModel
    ) {
        self.presenter = presenter
        self.didTapCell = didTapCell
        self.currentWeather = currentWeather
    }
    //MARK: Start
    func start() {
        let favoritesViewController = screens.createFavoritesViewController(
            didTapCell: didTapCell,
            currentWeather: currentWeather
        )
        presenter.pushViewController(favoritesViewController, animated: true)
    }
    
    func startSUI() {
        let favoritesVCSUI = screens.createFavoritesVCSUI(
            didTapCell: didTapCell,
            currentWeather: currentWeather
        )
    }
}
