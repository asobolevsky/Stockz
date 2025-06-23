import Combine
import XCTest
@testable import Stockz

final class HoldingsViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()

    func testHoldingsLoadedCorrectly() async {
        let holdings = [
            Stock(ticker: "RUNINC", name: "Runners Inc.", currency: "USD", currentPriceCents: 3614, quantity: 5, currentPriceTimestamp: 1681845832),
            Stock(ticker: "BAC", name: "Bank of America Corporation", currency: "USD", currentPriceCents: 2393, quantity: 10, currentPriceTimestamp: 1681845832)
        ]
        let store = AppStateStore(state: .init(portfolio: .init(holdings: holdings)))
        let viewModel = HoldingsViewModel(store: store)

        let expectation = XCTestExpectation(description: "Load holdings")
        viewModel.$state
            .compactMap { state in
                if case let .loaded(holdings) = state {
                    return holdings
                }
                return nil
            }
            .sink { holdings in
                XCTAssertEqual(holdings.count, 2)
                XCTAssertEqual(holdings[0].ticker, "RUNINC")
                XCTAssertEqual(holdings[1].ticker, "BAC")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        await viewModel.load()
        await fulfillment(of: [expectation], timeout: 1)
    }
}
