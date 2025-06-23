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
                throw TransactionCheckerError.insufficientBalance
            }

        case let .withdrawal(amount):
            if portfolio.balance.amount < amount { 
                throw TransactionCheckerError.insufficientBalance
            }
            
        case let .sell(ticker, shares, price):
            if
                let holding = portfolio.holdings.first(where: { $0.ticker == ticker }),
                holding.sharesQuantity < shares
            {
                throw TransactionCheckerError.insufficientShares
            }
            
        default: break
        }
    }
}
