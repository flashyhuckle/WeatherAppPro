import Foundation

protocol UserDefaultsWrapperInterface {
    func set<T: Encodable>(object: T, forKey: String) throws
    func get<T: Decodable>(forKey: String, castTo type: T.Type) throws -> T
    func update<T: Encodable>(object: T, forKey: String) throws
    func remove<T>(object: T, forKey: String)
}

final class UserDefaultsWrapper: UserDefaultsWrapperInterface {
    // MARK: - Error Types

    enum ErrorType: String, LocalizedError {
        case unableToEncode = "Unable to encode"
        case noValueForKey = "No value for provided key"
        case unableToDecode = "Unable to decode object"
        case unableToUpdate = "Unable to update object"

        var errorDescription: String? {
            rawValue
        }
    }

    // MARK: - Properties

    private let storage: UserDefaults
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    // MARK: - Initialization

    init(
        storage: UserDefaults = .standard,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.storage = storage
        self.encoder = encoder
        self.decoder = decoder
    }

    // MARK: - Set

    func set<T: Encodable>(object: T, forKey: String) throws {
        do {
            let data = try encoder.encode(object)
            storage.set(data, forKey: forKey)
        } catch {
            throw ErrorType.unableToEncode
        }
    }

    // MARK: - Get

    func get<T: Decodable>(forKey: String, castTo type: T.Type) throws -> T {
        guard let data = storage.data(forKey: forKey) else { throw ErrorType.noValueForKey }
        do {
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            throw ErrorType.unableToDecode
        }
    }

    // MARK: - Update

    func update<T: Encodable>(object: T, forKey: String) throws {
        remove(object: object, forKey: forKey)
        do {
            try set(object: object, forKey: forKey)
        } catch {
            throw ErrorType.unableToUpdate
        }
    }

    // MARK: - Remove

    func remove<T>(object _: T, forKey: String) {
        storage.removeObject(forKey: forKey)
    }
}
