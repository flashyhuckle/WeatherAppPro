import Foundation

class Favorites: ObservableObject {
    private var favorites: Set<String> {
        didSet {
            favoritesArray = favorites.map {$0}
            favoritesArray.sort()
        }
    }
    var favoritesArray = [String]()
    
    init() {
        if let defaults = UserDefaults.standard.object(forKey: Constants.favoritesSaveKey) as? [String] {
            favoritesArray = defaults.sorted()
            let set = Set(defaults.map {$0})
            favorites = set
        } else {
            favorites = []
        }
    }
    
    func buttonTapped(_ city: String) {
        if contains(city.capitalized) {
            remove(city.capitalized)
        } else {
            add(city.capitalized)
        }
    }
    
    func contains(_ city: String) -> Bool {
        favorites.contains(city.capitalized)
    }
    
    func favoriteCity(_ number: Int) -> String {
        favoritesArray[number]
    }
    
    func count() -> Int {
        return favorites.count
    }
    
    private func add(_ city: String) {
        objectWillChange.send()
        favorites.insert(city.capitalized)
        save()
    }
    
    private func remove(_ city: String) {
        objectWillChange.send()
        favorites.remove(city.capitalized)
        save()
    }
    
    private func save() {
        let array = favorites.map { $0 }
        UserDefaults.standard.set(array, forKey: Constants.favoritesSaveKey)
    }
}
