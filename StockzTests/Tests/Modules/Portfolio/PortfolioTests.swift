import XCTest
@testable import Stockz

class PortfolioTests: XCTestCase {
    func testPortfolioDecoding() throws {
        let data = """
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
        let portfolio = try JSONDecoder().decode(Portfolio.self, from: data)
        XCTAssertEqual(portfolio.stocks.count, 1)
        XCTAssertEqual(portfolio.stocks[0].ticker, "^GSPC")
        XCTAssertEqual(portfolio.stocks[0].name, "S&P 500")
        XCTAssertEqual(portfolio.stocks[0].currency, "USD")
        XCTAssertEqual(portfolio.stocks[0].currentPriceCents, 318157)
        XCTAssertEqual(portfolio.stocks[0].quantity, 100)
        XCTAssertEqual(portfolio.stocks[0].currentPriceTimestamp, 1681845832)
    }

    func testPortfolioDecodingEmptyQuantity() throws {
        let data = """
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
        let portfolio = try JSONDecoder().decode(Portfolio.self, from: data)
        XCTAssertEqual(portfolio.stocks.count, 1)
        XCTAssertEqual(portfolio.stocks[0].quantity, nil)
    }

    func testPortfolioMalformedJSON() throws {
        let data = """
        {
            "stocks": [
                {
                    "foo": "bar"
                }
            ]
        """.data(using: .utf8)!
        XCTAssertThrowsError(try JSONDecoder().decode(Portfolio.self, from: data))
    }
    
    func testPortfolioIncorrectJSON() throws {
        let data = """
        {
            "stocks": [
                {
                    "foo": "bar"
                }
            ]
        }
        """.data(using: .utf8)!
        XCTAssertThrowsError(try JSONDecoder().decode(Portfolio.self, from: data))
    }
}
