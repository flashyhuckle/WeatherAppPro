import Foundation
import CoreLocation
@testable import WeatherAppPro


final class MockApiManager: ApiManagerInterface {
    func fetchForecastWeather(city: String, onCompletion: @escaping ((Result<[WeatherAppPro.WeatherModel], Error>) -> Void)) {
        onCompletion(.success([WeatherModel.example]))
    }
    
    func fetchCurrentWeather(for city: String, onCompletion: @escaping ((Result<WeatherAppPro.WeatherModel, Error>) -> Void)) {
        onCompletion(.success(WeatherModel.example))
    }
    
    func fetchCurrentWeather(lat: Double, lon: Double, onCompletion: @escaping ((Result<WeatherAppPro.WeatherModel, Error>) -> Void)) {
        onCompletion(.success(WeatherModel.example))
    }
    
    
}

final class MockLocationManager: LocationManagerType {
    var didReceiveLocation: ((CLLocationCoordinate2D) -> Void)?
    func requestLocation() {
        didReceiveLocation?(CLLocationCoordinate2D())
    }
}

final class MockFavorites: FavoritesType {
    var favorites = Set<String>()
    
    func buttonTapped(_ city: String) {
        if favorites.contains(city) {
            favorites.remove(city)
        } else {
            favorites.insert(city)
        }
    }
    
    func contains(_ city: String) -> Bool {
        return favorites.contains(city)
    }
}

final class MockUserDefaultsWrapper: UserDefaultsWrapperInterface {
    var setHasBeenCalled: Bool = false
    var getHasBeenCalled: Bool = false
    var updateHasBeenCalled: Bool = false
    var removeHasBeenCalled: Bool = false

    func set<T>(object _: T, forKey _: String) throws where T: Encodable {
        setHasBeenCalled = true
    }

    func get<T>(forKey _: String, castTo _: T.Type) throws -> T where T: Decodable {
        getHasBeenCalled = true
        throw UserDefaultsWrapper.ErrorType.noValueForKey
    }

    func update<T>(object _: T, forKey _: String) throws where T: Encodable {
        updateHasBeenCalled = true
    }

    func remove<T>(object _: T, forKey _: String) {
        removeHasBeenCalled = true
    }
}
