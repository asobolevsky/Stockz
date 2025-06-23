import Foundation

final class StockDetailViewModel: ObservableObject {
    let portfolioService: PortfolioService
    @Published var errorMessage: String?
    
    init(portfolioService: PortfolioService = PortfolioServiceImpl()) {
        self.portfolioService = portfolioService
    }
    
    func buy(stock: Stock, shareCount: Int) {
        Task {
            do {
                try await portfolioService.buy(ticker: stock.ticker, shares: shareCount, price: stock.currentPrice)
            } catch let error as TransactionCheckerError {
                if case .insufficientBalance = error {
                    await updateErrorMessage("Insufficient balance")
                }
                throw error
            } catch {
                await updateErrorMessage("Failed to buy stocks")
            }
        }
    }
    
    func sell(stock: Stock, shareCount: Int) {
        Task {
            do {
                try await portfolioService.sell(ticker: stock.ticker, shares: shareCount, price: stock.currentPrice)
            } catch let error as TransactionCheckerError {
                if case .insufficientShares = error {
                    await updateErrorMessage("Insufficient shares")
                }
                throw error
            } catch {
                await updateErrorMessage("Failed to sell stocks")
            }
        }
    }
    
    @MainActor
    private func updateErrorMessage(_ errorMessage: String) {
        self.errorMessage = errorMessage
    }
}
