import Foundation

protocol PortfolioService {
    func currentPortfolio() -> Portfolio
    func deposit(amount: Double) throws
    func withdrawal(amount: Double) throws
    func buy(ticker: String, shares: Int, price: Double) throws
    func sell(ticker: String, shares: Int, price: Double) throws
}

final class PortfolioServiceImpl: PortfolioService {
    private let store: AppStateStore
    private let transactionChecker: TransactionChecking

    init(store: AppStateStore = .shared, transactionChecker: TransactionChecking = TransactionChecker()) {
        self.store = store
        self.transactionChecker = transactionChecker
    }

    func currentPortfolio() -> Portfolio {
        store[\.portfolio]
    }

    func deposit(amount: Double) throws {
        let transaction = Transaction(type: .deposit(amount: amount), status: .completed)
        try updatePortfolio(with: transaction)
    }

    func withdrawal(amount: Double) throws {
        let transaction = Transaction(type: .withdrawal(amount: amount), status: .completed)
        try updatePortfolio(with: transaction)
    }

    func buy(ticker: String, shares: Int, price: Double) throws {
        let transaction = Transaction(type: .buy(ticker: ticker, shares: shares, price: price), status: .completed)
        try updatePortfolio(with: transaction)
    }

    func sell(ticker: String, shares: Int, price: Double) throws {
        let transaction = Transaction(type: .sell(ticker: ticker, shares: shares, price: price), status: .completed)
        try updatePortfolio(with: transaction)
    }
    
    // MARK: - Update

    private func updatePortfolio(with transaction: Transaction) throws {
        var portfolio = store[\.portfolio]
        try performTransaction(transaction, on: &portfolio)
        store[\.portfolio] = portfolio
    }
    
    private func performTransaction(_ transaction: Transaction, on portfolio: inout Portfolio) throws {
        try transactionChecker.checkTransaction(transaction, in: portfolio)
        
        switch transaction.type {
        case .deposit(let amount):
            portfolio.balance.amount += amount

        case .withdrawal(let amount):
            portfolio.balance.amount -= amount

        case .buy(let ticker, let shares, let price):
            portfolio.balance.amount -= price * Double(shares)
            // If already have holding with this ticker
            if let index = portfolio.holdings.firstIndex(where: { $0.ticker == ticker }) {
                var quantity = portfolio.holdings[index].sharesQuantity
                quantity += shares
                portfolio.holdings[index].quantity = quantity
            } else if let index = portfolio.stocks.firstIndex(where: { $0.ticker == ticker }) {
                // If don't have yet holding with this ticker
                var stock = portfolio.stocks[index]
                stock.quantity = shares
                portfolio.holdings.append(stock)
            }

        case .sell(let ticker, let shares, let price):
            portfolio.balance.amount += price * Double(shares)
            if let index = portfolio.holdings.firstIndex(where: { $0.ticker == ticker }) {
                var quantity = portfolio.holdings[index].sharesQuantity
                quantity -= shares
                portfolio.holdings[index].quantity = quantity
                
                if portfolio.holdings[index].quantity == 0 {
                    portfolio.holdings.remove(at: index)
                }
            }
        }
    }
}

private extension String {
    static let portfolioKey = "portfolio"
}
