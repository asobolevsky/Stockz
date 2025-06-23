import Combine
import Foundation

final class AccountViewModel: ObservableObject, LoadableViewModel {
    @Published var state: ViewModelState<AccountInfo, Error> = .idle
    
    @MainActor
    func load() async {
        state = .loaded(
            AccountInfo(
                user: User(name: "John Doe"),
                portfolio: .init(
                    balance: .init(currency: "USD", amount: 5000),
                    transactions: [
                        .init(id: UUID(), type: .deposit(amount: 1000), date: Date(), status: .completed),
                        .init(id: UUID(), type: .buy(ticker: "AAPL", shares: 10, price: 150), date: Date(), status: .pending),
                        .init(id: UUID(), type: .sell(ticker: "FOO", shares: 5, price: 160), date: Date(), status: .completed),
                        .init(id: UUID(), type: .deposit(amount: 500), date: Date(), status: .failed),
                    ]
                )
            )
        )
    }
}

extension Transaction {
    var title: String {
        switch type {
        case .deposit:
            return "Deposit"
        case .withdrawal:
            return "Withdrawal"
        case .buy(let ticker, _, _):
            return "Buy \(ticker)"
        case .sell(let ticker, _, _):
            return "Sell \(ticker)"
        }
    }
}
