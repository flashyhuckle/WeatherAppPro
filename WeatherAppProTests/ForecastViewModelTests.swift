import Foundation
import XCTest
import CoreLocation
@testable import WeatherAppPro

class ForecastViewModelTests: XCTestCase {
    
    func test_viewDidLoad() {
        let expectedValue = [WeatherModel.example]

        let viewModel = createViewModel()

        viewModel.didReceiveData = { weather in
            XCTAssertEqual(weather, expectedValue)
        }

        viewModel.viewDidLoad()
    }
}

private extension ForecastViewModelTests {
    func createViewModel(
        apiManager: ApiManagerInterface = MockApiManager(),
        currentWeather: WeatherModel = WeatherModel.example
    ) -> ForecastViewModel {
        ForecastViewModel(
            apiManager: apiManager,
            currentWeather: currentWeather
        )
    }
}
