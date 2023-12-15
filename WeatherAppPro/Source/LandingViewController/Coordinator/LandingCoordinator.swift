import UIKit
import SwiftUI

protocol CoordinatorType {
    func start()
}

final class LandingCoordinator: CoordinatorType {

    //MARK: Properties
    private lazy var navigationController: UINavigationController = {
        let navController = UINavigationController()
        navController.navigationBar.tintColor = .white
        navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(.white)]
        return navController
    }()
    
    private var screens: LandingScreens = LandingScreens()
    private let presenter: UIWindow

//    private var onFavoritesTap: ((String) -> Void)?

    //MARK: Child Coordinators
    private var forecastCoordinator: ForecastCoordinator?
    private var favoritesCoordinator: FavoritesCoordinator?
    
    //MARK: Init
    init(presenter: UIWindow) {
        self.presenter = presenter
    }
    
    //MARK: Start
    func start() {
        let landingViewController = screens.createLandingViewController(currentWeather: WeatherModel.example) { [ weak self ] currentWeather in
            guard let self = self else { return }
            self.forecastCoordinator = ForecastCoordinator(
                presenter: self.navigationController,
                currentWeather: currentWeather
            )
            self.forecastCoordinator?.start()
        } didTapFavoritesButton: { [ weak self ] didTapCell, currentWeather in
            guard let self = self else { return }
            let closure: ((String) -> Void)? = { string in
                self.navigationController.popViewController(animated: true)
                didTapCell?(string)
            }
            self.favoritesCoordinator = FavoritesCoordinator(
                presenter: self.navigationController,
                didTapCell: closure,
                currentWeather: currentWeather
            )
            self.favoritesCoordinator?.start()
        }
        
        navigationController.viewControllers = [landingViewController]
        presenter.rootViewController = navigationController
    }
}
