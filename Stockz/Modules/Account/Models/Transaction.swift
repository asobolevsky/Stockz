import Foundation

struct Transaction: Equatable, Identifiable, Codable {
    enum TransactionType: Equatable, Codable {
        case deposit(amount: Double)
        case withdrawal(amount: Double)
        case buy(ticker: String, shares: Int, price: Double)
        case sell(ticker: String, shares: Int, price: Double)
    }

    enum TransactionStatus: String, Codable {
        case pending
        case completed
        case failed
    }

    let id: UUID
    let type: TransactionType
    let date: Date
    let status: TransactionStatus
}

extension Transaction {
    init(type: TransactionType, status: TransactionStatus) {
        self.id = UUID()
        self.type = type
        self.date = Date()
        self.status = status
    }

    var amount: Double {
        switch type {
        case .deposit(let amount), .withdrawal(let amount):
            return amount
        case .buy(_, let shares, let price), .sell(_, let shares, let price):
            return price * Double(shares)
        }
    }

    var formattedAmount: String {
        NumberFormatter.priceFormatter(with: "USD").string(from: NSNumber(value: amount)) ?? ""
    }

    var isPositive: Bool {
        switch type {
        case .deposit, .sell:
            return true
        case .withdrawal, .buy:
            return false
        }
    }
}
