import Foundation

protocol PersistenceManaging {
    func save<T: Encodable>(data: T, key: String) async throws
    func load<T: Decodable>(type: T.Type, key: String) async throws -> T?
}

actor PersistenceManager: PersistenceManaging {
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func save<T: Encodable>(data: T, key: String) async throws {
        let encoder = JSONEncoder()
        let encoded = try encoder.encode(data)
        userDefaults.set(encoded, forKey: key)
    }

    func load<T: Decodable>(type: T.Type, key: String) async throws -> T? {
        let decoder = JSONDecoder()
        guard let data = userDefaults.data(forKey: key) else { return nil }
        return try decoder.decode(type, from: data)
    }
}
