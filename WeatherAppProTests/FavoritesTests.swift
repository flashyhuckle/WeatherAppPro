import Foundation
import XCTest
@testable import WeatherAppPro

class FavoritesTests: XCTestCase {
    
    func test_buttonTapped() {
        let mockUserDefaultsWrapper = MockUserDefaultsWrapper()
        let sut = Favorites(storage: mockUserDefaultsWrapper)
        sut.buttonTapped(WeatherModel.example.cityName)
        
        XCTAssertTrue(sut.contains(WeatherModel.example.cityName))
        XCTAssertEqual(sut.favoritesArray, [WeatherModel.example.cityName])
        XCTAssertTrue(mockUserDefaultsWrapper.setHasBeenCalled)
    }
    
    func test_buttonTapped2ndTime() {
        let mockUserDefaultsWrapper = MockUserDefaultsWrapper()
        let favorites = Favorites(storage: mockUserDefaultsWrapper)
        favorites.buttonTapped(WeatherModel.example.cityName)
        favorites.buttonTapped(WeatherModel.example.cityName)
        
        XCTAssertFalse(favorites.contains(WeatherModel.example.cityName))
        XCTAssertEqual(favorites.favoritesArray, [])
        XCTAssertTrue(mockUserDefaultsWrapper.setHasBeenCalled)
    }
    
}
