import UIKit

struct ForecastCoordinator: CoordinatorType {
    
    //MARK: Properties
    private let screens: ForecastScreens = ForecastScreens()
    private let presenter: UINavigationController
    private var currentWeather: WeatherModel
    
    //MARK: Init
    init(
        presenter: UINavigationController,
        currentWeather: WeatherModel
    ) {
        self.presenter = presenter
        self.currentWeather = currentWeather
    }
    //MARK: Start
    func start() {
        let forecastViewController = screens.createForecastViewController(
            currentWeather: currentWeather
        )
        presenter.pushViewController(forecastViewController, animated: true)
    }
}
