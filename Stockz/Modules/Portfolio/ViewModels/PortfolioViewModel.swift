import Foundation
import Combine

final class PortfolioViewModel: ObservableObject, ViewModel {
    @Published var state: ViewModelState<[Stock], Error> = .idle

    private let service: StocksAPIProtocol

    init(service: StocksAPIProtocol = StocksApiService()) {
        self.service = service
    }

    func load() async {
        await updateState(.loading)

        do {
            let portfolio = try await service.fetchPortfolio()
            await updateState(.loaded(portfolio.stocks))
        } catch {
            await updateState(.failed(error))
        }
    }
}
