import Combine
import Foundation

@MainActor
final class StockListViewModel: ObservableObject {
    @Published private(set) var stocks: [Stock]
    @Published var searchText: String = ""

    private let initialStocks: [Stock]
    private var cancellables: Set<AnyCancellable> = []

    init(stocks: [Stock]) { 
        self.initialStocks = stocks
        self.stocks = stocks
        
        setObservers()
    }

    private func setObservers() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] val in
                self?.filterStocks()
            }
            .store(in: &cancellables)
    }

    func filterStocks() {
        if searchText.isEmpty {
            stocks = initialStocks
        } else {
            let lowercased = searchText.lowercased()
            stocks = initialStocks.filter { stock in
                stock.name.lowercased().contains(lowercased) ||
                stock.ticker.lowercased().contains(lowercased)
            }
        }
    }
}
