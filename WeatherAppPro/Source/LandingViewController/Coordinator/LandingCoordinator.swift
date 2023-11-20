import UIKit

protocol CoordinatorType {
    func start()
}

final class LandingCoordinator: CoordinatorType {

    //MARK: Properties
    private var navigationController: UINavigationController = UINavigationController()
    private var screens: LandingScreens = LandingScreens()
    private let presenter: UIWindow

//    func test(str: String) {
//        print(str)
//        navigationController.popViewController(animated: true)
//    }

    private var onFavoritesTap: ((String) -> Void)?

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
        } didTapFavoritesButton: { didTapCell in
            //            ((() -> Void) -> Void)?
//            self.favoritesCoordinator = FavoritesCoordinator(presenter: self.navigationController, didTapCell: self.test(str:))
            self.favoritesCoordinator = FavoritesCoordinator(
                presenter: self.navigationController,
                didTapCell: didTapCell
            )
            self.favoritesCoordinator?.start()
        }
        
        navigationController.viewControllers = [landingViewController]
        presenter.rootViewController = navigationController
    }
}
