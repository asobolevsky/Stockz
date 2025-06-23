import Foundation
import Combine

final class HoldingsViewModel: ObservableObject, LoadableViewModel {
    typealias T = [Stock]
    typealias E = Never
    
    @Published var state: ViewModelState<[Stock], Never> = .idle
    @Published var totalValueFormatted: String?
    
    private let store: AppStateStore
    
    init(store: AppStateStore = .shared) {
        self.store = store
    }
    
    func load() async {
        let holdings = store[\.portfolio.holdings]
        let totalValue = holdings.reduce(0) { result, stock in
            result + (stock.currentPrice * Double(stock.sharesQuantity))
        }
        Task { @MainActor in
            self.totalValueFormatted = NumberFormatter.priceFormatter(with: "USD")
                .string(from: NSNumber(value: totalValue))
        }
        
        await updateState(.loaded(holdings))
    }
}
