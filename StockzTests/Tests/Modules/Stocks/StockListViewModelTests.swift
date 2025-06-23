import XCTest
@testable import Stockz

@MainActor
final class StockListViewModelTests: XCTestCase {
    func testStocksFiltering() {
        let stocks = [
            Stock(ticker: "^GSPC", name: "S&P 500", currency: "USD", currentPriceCents: 318157, quantity: nil, currentPriceTimestamp: 1681845832),
            Stock(ticker: "RUNINC", name: "Runners Inc.", currency: "USD", currentPriceCents: 3614, quantity: 5, currentPriceTimestamp: 1681845832),
            Stock(ticker: "BAC", name: "Bank of America Corporation", currency: "USD", currentPriceCents: 2393, quantity: 10, currentPriceTimestamp: 1681845832),
            Stock(ticker: "EXPE", name: "Expedia Group, Inc.", currency: "USD", currentPriceCents: 8165, quantity: nil, currentPriceTimestamp: 1681845832),
            Stock(ticker: "GRUB", name: "Grubhub Inc.", currency: "USD", currentPriceCents: 6975, quantity: nil, currentPriceTimestamp: 1681845832)
        ]
        let viewModel = StockListViewModel(stocks: stocks)

        viewModel.searchText = "RU"
        viewModel.filterStocks()
        
        XCTAssertEqual(viewModel.stocks.count, 2)
        XCTAssertEqual(viewModel.stocks[0].ticker, "RUNINC")
        XCTAssertEqual(viewModel.stocks[1].ticker, "GRUB")
    }
}
