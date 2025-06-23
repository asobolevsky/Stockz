import Foundation

final class HoldingsListViewModel: ObservableObject {
    @Published var stocks: [Stock] = []

    func fetchHoldings() async throws {
//        let holdings = try await HoldingsService.shared.fetchHoldings()
//        self.holdings = holdings
    }
}
