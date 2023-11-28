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
    func start() {
        let landingViewController = screens.createLandingViewController(currentCity: "warsaw") { [ weak self ] city, weatherType in
            guard let self = self else { return }
            self.forecastCoordinator = ForecastCoordinator(
                presenter: self.navigationController,
                city: city,
                weatherType: weatherType
            )
            self.forecastCoordinator?.start()
        } didTapFavoritesButton: { didTapCell, weatherType  in
            self.favoritesCoordinator = FavoritesCoordinator(
                presenter: self.navigationController,
                didTapCell: didTapCell,
                weatherType: weatherType
            )
            self.favoritesCoordinator?.start()
        } didTapSwiftUIButton: { viewModel in
            let view = UIHostingController(rootView: LandingVCSUI(viewModel: viewModel))
                    view.rootView.dismiss = {
                        let landing = LandingCoordinator(presenter: self.presenter)
                        landing.start()
                    }
            self.presenter.rootViewController = view
            self.presenter.makeKeyAndVisible()
        }
        
        navigationController.viewControllers = [landingViewController]
        presenter.rootViewController = navigationController
    }
}
