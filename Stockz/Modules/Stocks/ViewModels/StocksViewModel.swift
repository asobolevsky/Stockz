import Combine
import Foundation

final class StocksViewModel: ObservableObject, LoadableViewModel {
    @Published var state: ViewModelState<[Stock], Error> = .idle

    private let service: StocksProtocol

    init(service: StocksProtocol = StocksService()) {
        self.service = service
    }

    func load() async {
        await updateState(.loading)

        do {
            let stocks = try await service.fetchStocks()
            await updateState(.loaded(stocks))
        } catch {
            await updateState(.failed(error))
        }
    }
}
