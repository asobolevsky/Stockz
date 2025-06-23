import Foundation
import Combine

protocol StocksProtocol {
    func fetchStocks() async throws -> [Stock]
}

enum StocksServiceError: Error {
    case invalidResponse
}

final class StocksService: StocksProtocol {
    private let networkManager: NetworkManaging
    private let endpoint: URL
    
    init(
        networkManager: NetworkManaging = NetworkManager(),
        endpoint: URL = URL(string: "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio.json")!
    ) {
        self.networkManager = networkManager
        self.endpoint = endpoint
    }
    
    func fetchStocks() async throws -> [Stock] {
        let (data, response) = try await networkManager.data(for: URLRequest(url: endpoint))
        guard let http = response as? HTTPURLResponse, 200..<300 ~= http.statusCode else {
            throw StocksServiceError.invalidResponse
        }
        let result = try JSONDecoder().decode(StocksListAPIResponse.self, from: data)
        // Simulate price diff
        let stocks = result.stocks.map { stock in
            var stock = stock
            stock.priceDiff = Double.random(in: -0.05...0.05)
            return stock
        }
        return stocks
    }
}
