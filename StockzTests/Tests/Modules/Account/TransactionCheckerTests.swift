import XCTest
@testable import Stockz

final class TransactionCheckerTests: XCTestCase {
    func testBuyTransactionSuccess() {
        let portfolio = Portfolio(balance: .init(currency: "USD", amount: 1000))
        
        XCTAssertNoThrow {
            let checker = TransactionChecker()
            try checker.checkTransaction(.init(type: .buy(ticker: "UA", shares: 10, price: 100), status: .completed), in: portfolio)
        }
    }
    
    func testBuyTransactionFailed() {
        let portfolio = Portfolio(balance: .init(currency: "USD", amount: 100))
        
        let checker = TransactionChecker()
        XCTAssertThrowsError(
            try checker.checkTransaction(.init(type: .buy(ticker: "UA", shares: 10, price: 100), status: .completed), in: portfolio)
        ) { error in
            XCTAssertEqual(error as? TransactionCheckerError, .insufficientBalance)
        }
    }
    
    func testWithdrawalTransactionSuccess() {
        let portfolio = Portfolio(balance: .init(currency: "USD", amount: 1000))
        
        XCTAssertNoThrow {
            let checker = TransactionChecker()
            try checker.checkTransaction(.init(type: .withdrawal(amount: 100), status: .completed), in: portfolio)
        }
    }
    
    func testWithdrawalTransactionFailed() {
        let portfolio = Portfolio(balance: .init(currency: "USD", amount: 100))
        
        let checker = TransactionChecker()
        XCTAssertThrowsError(
            try checker.checkTransaction(.init(type: .withdrawal(amount: 1000), status: .completed), in: portfolio)
        ) { error in
            XCTAssertEqual(error as? TransactionCheckerError, .insufficientBalance)
        }
    }
    
    func testSellTransactionSuccess() {
        let portfolio = Portfolio(
            balance: .init(currency: "USD", amount: 1000),
            holdings: [
                Stock(ticker: "UA", name: "Under Armour, Inc.", currency: "USD", currentPriceCents: 844, quantity: 7, currentPriceTimestamp: 1681845832)
            ]
        )
        
        XCTAssertNoThrow {
            let checker = TransactionChecker()
            try checker.checkTransaction(.init(type: .sell(ticker: "UA", shares: 5, price: 100), status: .completed), in: portfolio)
        }
    }
    
    func testSellTransactionFailed() {
        let portfolio = Portfolio(
            balance: .init(currency: "USD", amount: 1000),
            holdings: [
                Stock(ticker: "UA", name: "Under Armour, Inc.", currency: "USD", currentPriceCents: 844, quantity: 7, currentPriceTimestamp: 1681845832)
            ]
        )
        
        let checker = TransactionChecker()
        XCTAssertThrowsError(
            try checker.checkTransaction(.init(type: .sell(ticker: "UA", shares: 10, price: 100), status: .completed), in: portfolio)
        ) { error in
            XCTAssertEqual(error as? TransactionCheckerError, .insufficientShares)
        }
    }
}
