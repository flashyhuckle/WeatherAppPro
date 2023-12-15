import Foundation

protocol FavoritesType {
    func buttonTapped(_ city: String)
    func contains(_ city: String) -> Bool
}

class Favorites: FavoritesType {
    private var favorites: Set<String> {
        didSet {
            favoritesArray = favorites.map {$0}
            favoritesArray.sort()
        }
    }
    var favoritesArray = [String]()
    let storage: UserDefaultsWrapperInterface
    
    init(
        storage: UserDefaultsWrapperInterface = UserDefaultsWrapper()
    ) {        
        self.storage = storage
        do {
            let defaults = try storage.get(forKey: Constants.favoritesSaveKey, castTo: [String].self)
            favoritesArray = defaults.sorted()
            let set = Set(defaults.map {$0})
            favorites = set
        } catch {
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
//        objectWillChange.send()
        favorites.insert(city.capitalized)
        save()
    }
    
    private func remove(_ city: String) {
//        objectWillChange.send()
        favorites.remove(city.capitalized)
        save()
    }
    
    private func save() {
        let array = favorites.map { $0 }
        do {
            try storage.set(object: array, forKey: Constants.favoritesSaveKey)
        } catch {
            print("Favorites: Failed to save data.")
        }
    }
}
