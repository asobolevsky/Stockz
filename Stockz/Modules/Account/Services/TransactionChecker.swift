import Foundation

protocol TransactionChecking {
    func checkTransaction(_ transaction: Transaction, in portfolio: Portfolio) throws
}

enum TransactionCheckerError: Error {
    case insufficientBalance
    case insufficientShares
}

final class TransactionChecker: TransactionChecking {
    func checkTransaction(_ transaction: Transaction, in portfolio: Portfolio) throws {
        switch transaction.type {
        case let .buy(_, shares, price):
            let totalPrice = price * Double(shares)
            if portfolio.balance.amount < totalPrice { 
                throw PortfolioError.insufficientBalance 
            }

        case let .withdrawal(amount):
            if portfolio.balance.amount < amount { 
                throw PortfolioError.insufficientBalance 
            }
            
        case let .sell(ticker, shares, price):
            guard let holding = portfolio.holdings.first(where: { $0.ticker == ticker }) else {
                throw TransactionCheckerError.insufficientShares
            }

            let totalPrice = price * Double(shares)
            if portfolio.balance.amount < totalPrice {
                throw TransactionCheckerError.insufficientBalance
            }
            
        default: break
        }
    }
}
