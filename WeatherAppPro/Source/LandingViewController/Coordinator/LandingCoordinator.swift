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

    private var onFavoritesTap: ((String) -> Void)?

    //MARK: Child Coordinators
    private var forecastCoordinator: ForecastCoordinator?
    private var favoritesCoordinator: FavoritesCoordinator?
    
    //MARK: Init
    init(presenter: UIWindow) {
        self.presenter = presenter
    }
    
    //MARK: Start
//    func start() {
//        let landingViewController = screens.createLandingViewController(currentWeather: WeatherModel.example) { [ weak self ] currentWeather in
//            guard let self = self else { return }
//            self.forecastCoordinator = ForecastCoordinator(
//                presenter: self.navigationController,
//                currentWeather: currentWeather
//            )
//            self.forecastCoordinator?.start()
//        } didTapFavoritesButton: { didTapCell, currentWeather in
//            self.favoritesCoordinator = FavoritesCoordinator(
//                presenter: self.navigationController,
//                didTapCell: didTapCell,
//                currentWeather: currentWeather
//            )
//            self.favoritesCoordinator?.start()
//        } didTapUIButton: { viewModel in
//            let view = UIHostingController(rootView: LandingVCSUI(viewModel: viewModel, currentWeather: viewModel.currentWeather))
//            view.rootView.goToUIKIT = {
//                let landing = LandingCoordinator(presenter: self.presenter)
//                landing.start(with: viewModel.currentWeather)
//            }
//            self.presenter.rootViewController = view
//            self.presenter.makeKeyAndVisible()
//        }
//        
//        navigationController.viewControllers = [landingViewController]
//        presenter.rootViewController = navigationController
//    }

//    func start(with currentWeather: WeatherModel) {
//        let landingViewController = screens.createLandingViewController(currentWeather: currentWeather) { [ weak self ] currentWeather in
//            guard let self = self else { return }
//            self.forecastCoordinator = ForecastCoordinator(
//                presenter: self.navigationController,
//                currentWeather: currentWeather
//            )
//            self.forecastCoordinator?.start()
//        } didTapFavoritesButton: { didTapCell, currentWeather in
//            self.favoritesCoordinator = FavoritesCoordinator(
//                presenter: self.navigationController,
//                didTapCell: didTapCell,
//                currentWeather: currentWeather
//            )
//            self.favoritesCoordinator?.start()
//        } didTapUIButton: { viewModel in
//            let view = UIHostingController(rootView: LandingVCSUI(viewModel: viewModel, currentWeather: viewModel.currentWeather))
//            view.rootView.goToUIKIT = {
//                let landing = LandingCoordinator(presenter: self.presenter)
//                landing.start(with: viewModel.currentWeather)
//            }
//            self.presenter.rootViewController = view
//            self.presenter.makeKeyAndVisible()
//        }
//        
//        navigationController.viewControllers = [landingViewController]
//        presenter.rootViewController = navigationController
//    }
    
    func start() {
        let landingViewController = screens.createLandingViewController(currentWeather: WeatherModel.example) { [ weak self ] currentWeather in
            guard let self = self else { return }
            self.forecastCoordinator = ForecastCoordinator(
                presenter: self.navigationController,
                currentWeather: currentWeather
            )
            self.forecastCoordinator?.start()
        } didTapFavoritesButton: { didTapCell, currentWeather in
            self.favoritesCoordinator = FavoritesCoordinator(
                presenter: self.navigationController,
                didTapCell: didTapCell,
                currentWeather: currentWeather
            )
            self.favoritesCoordinator?.start()
        } didTapUIButton: { viewModel in
            let landing = LandingCoordinator(presenter: self.presenter)
            landing.startSUI(with: viewModel.currentWeather)
        }
        
        navigationController.viewControllers = [landingViewController]
        presenter.rootViewController = navigationController
    }
    
    func startUIKit(with currentWeather: WeatherModel) {
        let landingViewController = screens.createLandingViewController(currentWeather: currentWeather) { [ weak self ] currentWeather in
            guard let self = self else { return }
            self.forecastCoordinator = ForecastCoordinator(
                presenter: self.navigationController,
                currentWeather: currentWeather
            )
            self.forecastCoordinator?.start()
        } didTapFavoritesButton: { didTapCell, currentWeather in
            self.favoritesCoordinator = FavoritesCoordinator(
                presenter: self.navigationController,
                didTapCell: didTapCell,
                currentWeather: currentWeather
            )
            self.favoritesCoordinator?.start()
        } didTapUIButton: { viewModel in
            let landing = LandingCoordinator(presenter: self.presenter)
            landing.startSUI(with: viewModel.currentWeather)
        }
        
        navigationController.viewControllers = [landingViewController]
        presenter.rootViewController = navigationController
    }
    
    func startSUI(with currentWeather: WeatherModel) {
        let landingViewController = screens.createLandingVCSUI(currentWeather: currentWeather) { [ weak self ] currentWeather in
            guard let self = self else { return }
//            self.forecastCoordinator = ForecastCoordinator(
//                presenter: self.navigationController,
//                currentWeather: currentWeather
//            )
//            self.forecastCoordinator?.start()
        } didTapFavoritesButton: { didTapCell, currentWeather in
//            self.favoritesCoordinator = FavoritesCoordinator(
//                presenter: self.navigationController,
//                didTapCell: didTapCell,
//                currentWeather: currentWeather
//            )
//            self.favoritesCoordinator?.start()
        } didTapUIButton: { viewModel in
            let landing = LandingCoordinator(presenter: self.presenter)
            landing.startUIKit(with: viewModel.currentWeather)
        }
        presenter.rootViewController = landingViewController
    }
}
