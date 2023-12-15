import UIKit

struct ForecastScreens {
    func createForecastViewController(
        currentWeather: WeatherModel
    ) -> UIViewController {
        let viewModel = ForecastViewModel(
            apiManager: ApiManager(
                urlCreator: WeatherURLCreator(),
                requestPerformer: RequestPerformer()
            ),
            currentWeather: currentWeather
            
        )
        return ForecastViewController(viewModel: viewModel)
    }
}
