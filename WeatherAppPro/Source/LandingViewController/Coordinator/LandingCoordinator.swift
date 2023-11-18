import UIKit

protocol CoordinatorType {
    func start()
}

final class LandingCoordinator: CoordinatorType {
    
    //MARK: Properties
    private var navigationController: UINavigationController = UINavigationController()
    private var screens: LandingScreens = LandingScreens()
    private let presenter: UIWindow
    func test(str: String) {
        print(str)
    }
    
    //MARK: Child Coordinators
    private var forecastCoordinator: ForecastCoordinator?
    private var favoritesCoordinator: FavoritesCoordinator?
    
    //MARK: Init
    init(presenter: UIWindow) {
        self.presenter = presenter
    }
    
    //MARK: Start
    func start() {
        let landingViewController = screens.createLandingViewController(currentCity: "paris") { [ weak self ] city in
            guard let self = self else { return }
            self.forecastCoordinator = ForecastCoordinator(presenter: self.navigationController, city: city)
            self.forecastCoordinator?.start()
        } didTapFavoritesButton: {
            self.favoritesCoordinator = FavoritesCoordinator(presenter: self.navigationController, didTapCell: self.test(str:))
            //funkcja ktora zwraca Stringa city
            self.favoritesCoordinator?.start()
        }
        
        navigationController.viewControllers = [landingViewController]
        presenter.rootViewController = navigationController
    }
}
