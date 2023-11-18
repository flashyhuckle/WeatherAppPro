import UIKit

struct ForecastScreens {
    func createForecastViewController(
        city: String
    ) -> UIViewController {
        let viewModel = ForecastViewModel(
            city: city,
            apiManager: ApiManager()
        )
        return ForecastViewController(viewModel: viewModel)
    }
}
