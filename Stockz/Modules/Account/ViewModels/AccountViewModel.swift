import Combine
import Foundation

final class AccountViewModel: ObservableObject, LoadableViewModel {
    @Published var state: ViewModelState<AccountInfo, Error> = .idle
    private let store: AppStateStore
    
    init(store: AppStateStore = .shared) {
        self.store = store
    }

    @MainActor
    func load() async {
        state = .loaded(
            AccountInfo(
                user: store[\.user],
                portfolio: store[\.portfolio]
            )
        )
    }
    
    @MainActor
    func addFunds(amount: Double) async {
        store[\.portfolio.balance.amount] += amount
        
        let newTransaction = Transaction(
            type: .deposit(amount: amount),
            status: .completed
        )
        
        store[\.portfolio.transactions].insert(newTransaction, at: 0)
        
        state = .loaded(
            AccountInfo(
                user: store[\.user],
                portfolio: store[\.portfolio]
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
