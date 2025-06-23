import Combine
import XCTest
@testable import Stockz

class StocksViewModelTests: XCTestCase {
    var networkManagerMock: NetworkManagerMock!
    var service: StocksService!
    var viewModel: StocksViewModel!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        networkManagerMock = NetworkManagerMock()
        service = StocksService(networkManager: networkManagerMock)
        viewModel = StocksViewModel(service: service)
    }
    
    func testLoadPortfolio() async {
        let mockData: Data = """
        {
            "stocks": [
                {
                    "ticker": "^GSPC",
                    "name": "S&P 500",
                    "currency": "USD",
                    "current_price_cents": 318157,
                    "quantity": 100,
                    "current_price_timestamp": 1681845832
                }
            ]
        }
        """.data(using: .utf8)!
        networkManagerMock.dataHandler = { request in
            return (mockData, HTTPURLResponse.mock(url: request.url!))
        }

        let expectation = XCTestExpectation(description: "Load portfolio")
        viewModel.$state
            .compactMap { state in
                if case let .loaded(stocks) = state {
                    return stocks
                }
                return nil
            }
            .sink { stocks in
                XCTAssertEqual(stocks.count, 1)
                XCTAssertEqual(stocks[0].ticker, "^GSPC")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        await viewModel.load()
        await fulfillment(of: [expectation], timeout: 1)
    }

    func testLoadPortfolioError() async {
        networkManagerMock.dataHandler = { request in
            throw ErrorMock.invalidResponse
        }

        let expectation = XCTestExpectation(description: "Load portfolio")
        viewModel.$state
            .compactMap { state in
                if case let .failed(error) = state {
                    return error
                }
                return nil
            }
            .sink { error in
                XCTAssertEqual(error as? ErrorMock, .invalidResponse)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        await viewModel.load()
        await fulfillment(of: [expectation], timeout: 1)
    }
}
