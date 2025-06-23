import Foundation
@testable import Stockz

final class NetworkManagerMock: NetworkManaging {
    var dataCallCount = 0
    var dataHandler: ((URLRequest) async throws-> (Data, URLResponse))?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        dataCallCount += 1
        
        if let dataHandler {
            return try await dataHandler(request)
        }
        
        return (.init(), HTTPURLResponse.mock(url: request.url!))
    }
}
