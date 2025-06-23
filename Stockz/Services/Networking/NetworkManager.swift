import Foundation

protocol NetworkManaging {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

final class NetworkManager: NetworkManaging {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await session.data(for: request)
    }
}
