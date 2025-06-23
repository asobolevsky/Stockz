import Combine
import Foundation

final class StocksViewModel: ObservableObject, LoadableViewModel {
    @Published var state: ViewModelState<[Stock], Error> = .idle

    private let service: StocksProtocol
    private let store: AppStateStore

    init(service: StocksProtocol = StocksService(), store: AppStateStore = .shared) {
        self.service = service
        self.store = store
    }

    func load() async {
        await updateState(.loading)

        do {
            let stocks = try await service.fetchStocks()
            updateStore(with: stocks)
            await updateState(.loaded(stocks))
        } catch {
            await updateState(.failed(error))
        }
    }
    
    private func updateStore(with stocks: [Stock]) {
        let holdings = stocks.filter { $0.sharesQuantity > 0 }
        store.update { state in
            state.portfolio.stocks = stocks
            state.portfolio.holdings = holdings
        }
    }
}
