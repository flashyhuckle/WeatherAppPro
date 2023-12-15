import Foundation

final class FavoritesViewModel {
    let favorites: Favorites
    let didTapCell: ((String) -> Void)?
    let currentWeather: WeatherModel
    
    init(
        favorites: Favorites,
        didTapCell: ((String) -> Void)?,
        currentWeather: WeatherModel
    ) {
        self.favorites = favorites
        self.didTapCell = didTapCell
        self.currentWeather = currentWeather
    }
    
    func didTapCell(_ number: Int) {
        didTapCell?(favorites.favoriteCity(number))
    }
}
