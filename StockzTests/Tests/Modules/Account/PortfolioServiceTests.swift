import XCTest
@testable import Stockz

final class PortfolioServiceTests: XCTestCase {
    private var store: AppStateStore!
    private var service: PortfolioService!

    override func setUp() {
        super.setUp()
        store = AppStateStore(state: .init())
        service = PortfolioServiceImpl(store: store)
    }

    func testCurrentPortfolio() throws {
        store[\.portfolio] = .init(balance: .init(currency: "USD", amount: 1000))
        
        let portfolio = service.currentPortfolio()

        XCTAssertEqual(portfolio.balance.amount, 1000)
        XCTAssertEqual(portfolio.balance.currency, "USD")
    }

    func testDeposit() throws {
        store[\.portfolio] = .init(balance: .init(currency: "USD", amount: 1000))

        try service.deposit(amount: 100)

        let portfolio = service.currentPortfolio()
        XCTAssertEqual(portfolio.balance.amount, 1100)
    }
    
    func testWithdraw() throws {
        store[\.portfolio] = .init(balance: .init(currency: "USD", amount: 1000))

        try service.withdrawal(amount: 100)

        let portfolio = service.currentPortfolio()
        XCTAssertEqual(portfolio.balance.amount, 900)
    }

    func testBuyStockInHoldings() throws {
        store[\.portfolio] = .init(
            balance: .init(currency: "USD", amount: 1000), 
            holdings: [
                Stock(ticker: "UA", name: "Under Armour, Inc.", currency: "USD", currentPriceCents: 844, quantity: 7, currentPriceTimestamp: 1681845832)
            ]
        )

        try service.buy(ticker: "UA", shares: 10, price: 90)

        let portfolio = service.currentPortfolio()
        XCTAssertEqual(portfolio.balance.amount, 100)
        XCTAssertEqual(portfolio.holdings.count, 1)
        XCTAssertEqual(portfolio.holdings[0].ticker, "UA")
        XCTAssertEqual(portfolio.holdings[0].sharesQuantity, 17)
    }

    func testBuyNewStock() throws {
        store[\.portfolio] = .init(
            balance: .init(currency: "USD", amount: 1000), 
            stocks: [
                Stock(ticker: "UA", name: "Under Armour, Inc.", currency: "USD", currentPriceCents: 844, currentPriceTimestamp: 1681845832)
            ]
        )

        try service.buy(ticker: "UA", shares: 10, price: 90)

        let portfolio = service.currentPortfolio()
        XCTAssertEqual(portfolio.balance.amount, 100)
        XCTAssertEqual(portfolio.holdings.count, 1)
        XCTAssertEqual(portfolio.holdings[0].ticker, "UA")
        XCTAssertEqual(portfolio.holdings[0].sharesQuantity, 10)
    }
    
    func testSellHoldingPartially() throws {
        store[\.portfolio] = .init(
            balance: .init(currency: "USD", amount: 1000),
            holdings: [
                Stock(ticker: "UA", name: "Under Armour, Inc.", currency: "USD", currentPriceCents: 844, quantity: 7, currentPriceTimestamp: 1681845832)
            ]
        )

        try service.sell(ticker: "UA", shares: 5, price: 90)

        let portfolio = service.currentPortfolio()
        XCTAssertEqual(portfolio.balance.amount, 1450)
        XCTAssertEqual(portfolio.holdings.count, 1)
        XCTAssertEqual(portfolio.holdings[0].ticker, "UA")
        XCTAssertEqual(portfolio.holdings[0].sharesQuantity, 2)
    }

    func testSellWholeHolding() throws {
        store[\.portfolio] = .init(
            balance: .init(currency: "USD", amount: 1000),
            holdings: [
                Stock(ticker: "UA", name: "Under Armour, Inc.", currency: "USD", currentPriceCents: 844, quantity: 7, currentPriceTimestamp: 1681845832)
            ]
        )

        try service.sell(ticker: "UA", shares: 7, price: 90)

        let portfolio = service.currentPortfolio()
        XCTAssertEqual(portfolio.balance.amount, 1630)
        XCTAssertEqual(portfolio.holdings.count, 0)
    }

}
