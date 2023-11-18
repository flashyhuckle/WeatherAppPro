import UIKit

struct ForecastCoordinator: CoordinatorType {
    
    //MARK: Properties
    private let screens: ForecastScreens = ForecastScreens()
    private let presenter: UINavigationController
    private var city: String
    
    //MARK: Init
    init(presenter: UINavigationController, city: String) {
        self.presenter = presenter
        self.city = city
    }
    //MARK: Start
    func start() {
        let forecastViewController = screens.createForecastViewController(city: city)
        presenter.pushViewController(forecastViewController, animated: true)
    }
}
