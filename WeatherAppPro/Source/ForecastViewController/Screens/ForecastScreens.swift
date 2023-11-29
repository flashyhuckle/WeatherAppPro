import UIKit

struct ForecastScreens {
    func createForecastViewController(
        currentWeather: WeatherModel
    ) -> UIViewController {
        let viewModel = ForecastViewModel(
            apiManager: ApiManager(),
            currentWeather: currentWeather
            
        )
        return ForecastViewController(viewModel: viewModel)
    }
}
