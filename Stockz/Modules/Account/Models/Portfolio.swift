import Foundation

struct Portfolio: Equatable, Codable {
    var balance: Balance = .init(currency: "USD", amount: 0)
    var transactions: [Transaction] = []
    var stocks: [Stock] = []
    var holdings: [Stock] = []
}
