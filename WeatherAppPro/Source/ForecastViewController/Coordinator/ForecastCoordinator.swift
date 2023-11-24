import UIKit

struct ForecastCoordinator: CoordinatorType {
    
    //MARK: Properties
    private let screens: ForecastScreens = ForecastScreens()
    private let presenter: UINavigationController
    private var city: String
    private var weatherType: WeatherType?
    
    //MARK: Init
    init(presenter: UINavigationController, city: String, weatherType: WeatherType?) {
        self.presenter = presenter
        self.city = city
        self.weatherType = weatherType
    }
    //MARK: Start
    func start() {
        let forecastViewController = screens.createForecastViewController(
            city: city,
            weatherType: weatherType
        )
        presenter.pushViewController(forecastViewController, animated: true)
    }
}
