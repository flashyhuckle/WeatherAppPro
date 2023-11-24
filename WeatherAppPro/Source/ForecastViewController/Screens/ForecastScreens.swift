import UIKit

struct ForecastScreens {
    func createForecastViewController(
        city: String,
        weatherType: WeatherType?
    ) -> UIViewController {
        let viewModel = ForecastViewModel(
            city: city,
            apiManager: ApiManager(),
            weatherType: weatherType
            
        )
        return ForecastViewController(viewModel: viewModel)
    }
}
