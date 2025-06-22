import XCTest
@testable import Stockz

class NetworkManagerTests: XCTestCase {
    func testData() async throws {
        let networkManager = NetworkManager()
        let data = try await networkManager.data(for: URLRequest(url: URL(string: "https://www.google.com")!))
        XCTAssertTrue(data.0.count > 0)
    }
}
