import Foundation

protocol PortfolioService {
    func currentPortfolio() async throws -> Portfolio
    func deposit(amount: Double) async throws -> Portfolio
    func withdrawal(amount: Double) async throws -> Portfolio
    func buy(ticker: String, shares: Int, price: Double) async throws -> Portfolio
    func sell(ticker: String, shares: Int, price: Double) async throws -> Portfolio
}

enum PortfolioError: Error {
    case insufficientBalance
}

final class PortfolioServiceImpl: PortfolioService {
    private let persistenceManager: PersistenceManaging
    private let transactionChecker: TransactionChecking

    init(persistenceManager: PersistenceManaging = PersistenceManager(),
         transactionChecker: TransactionChecking = TransactionChecker()) {
        self.persistenceManager = persistenceManager
        self.transactionChecker = transactionChecker
    }

    func currentPortfolio() async throws -> Portfolio {
        return try await loadPortfolio()
    }

    func deposit(amount: Double) async throws -> Portfolio {
        let transaction = Transaction(type: .deposit(amount: amount), status: .completed)
        return try await updatePortfolio(with: transaction)
    }

    func withdrawal(amount: Double) async throws -> Portfolio {
        let transaction = Transaction(type: .withdrawal(amount: amount), status: .completed)
        return try await updatePortfolio(with: transaction)
    }

    func buy(ticker: String, shares: Int, price: Double) async throws -> Portfolio {
        let transaction = Transaction(type: .buy(ticker: ticker, shares: shares, price: price), status: .completed)
        return try await updatePortfolio(with: transaction)
    }

    func sell(ticker: String, shares: Int, price: Double) async throws -> Portfolio {
        let transaction = Transaction(type: .sell(ticker: ticker, shares: shares, price: price), status: .completed)
        return try await updatePortfolio(with: transaction)
    }
    
    // MARK: - Update

    private func updatePortfolio(with transaction: Transaction) async throws -> Portfolio {
        var portfolio = try await loadPortfolio()
        try await performTransaction(transaction, on: &portfolio)
        try await savePortfolio(portfolio)
        return portfolio
    }
    
    private func performTransaction(_ transaction: Transaction, on portfolio: inout Portfolio) async throws {
        try transactionChecker.checkTransaction(transaction, in: portfolio)
        
        // TODO:
    }
    
    // MARK: - Persistance

    private func loadPortfolio() async throws -> Portfolio {
        return try await persistenceManager.load(type: Portfolio.self, key: .portfolioKey) ?? .init()
    }

    private func savePortfolio(_ portfolio: Portfolio) async throws {
        try await persistenceManager.save(data: portfolio, key: .portfolioKey)
    }
}

private extension String {
    static let portfolioKey = "portfolio"
}
