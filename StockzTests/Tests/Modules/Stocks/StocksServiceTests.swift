import XCTest
@testable import Stockz

final class StocksServiceTests: XCTestCase {
    private var service: StocksService!
    private var networkManagerMock: NetworkManagerMock!

    override func setUp() {
        super.setUp()
        networkManagerMock = NetworkManagerMock()
        service = StocksService(networkManager: networkManagerMock)
    }
    
    func testFetchPortfolioHasOneStock() async throws {
        let mockData = """
        {
            "stocks": [
                {
                    "ticker": "^GSPC",
                    "name": "S&P 500",
                    "currency": "USD",
                    "current_price_cents": 318157,
                    "quantity": null,
                    "current_price_timestamp": 1681845832
                }
            ]
        }
        """.data(using: .utf8)!
        networkManagerMock.dataHandler = { request in
            return (mockData, HTTPURLResponse.mock(url: request.url!))
        }

        let stocks = try await service.fetchStocks()
        XCTAssertEqual(stocks.count, 1)
    }

    func testFetchPortfolioEmpty() async throws {
        let mockData = """
        {
            "stocks": []
        }
        """.data(using: .utf8)!
        networkManagerMock.dataHandler = { request in
            return (mockData, HTTPURLResponse.mock(url: request.url!))
        }

        let stocks = try await service.fetchStocks()
        XCTAssertEqual(stocks.count, 0)
    }

    func testFetchPortfolioInvalidResponse() async throws {
        networkManagerMock.dataHandler = { request in
            throw ErrorMock.invalidResponse
        }

        do {
            _ = try await service.fetchStocks()
        } catch {
            XCTAssertEqual(error as? ErrorMock, .invalidResponse)
        }
    }
    
    func testFetchPortfolioNotSuccessStatusCode() async throws {
        networkManagerMock.dataHandler = { request in
            return (Data(), HTTPURLResponse.mock(url: request.url!, statusCode: 400))
        }

        do {
            _ = try await service.fetchStocks()
        } catch {
            XCTAssertEqual(error as? StocksServiceError, StocksServiceError.invalidResponse)
        }
    }
}
