import Foundation
import Combine

protocol StocksAPIProtocol {
    func fetchPortfolio() async throws -> Portfolio
}

enum PortfolioServiceError: Error {
    case invalidResponse
}

final class StocksApiService: StocksAPIProtocol {
    private let networkManager: NetworkManaging
    private let endpoint: URL
    
    init(
        networkManager: NetworkManaging = NetworkManager(),
        endpoint: URL = URL(string: "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio.json")!
    ) {
        self.networkManager = networkManager
        self.endpoint = endpoint
    }
    
    func fetchPortfolio() async throws -> Portfolio {
        let (data, response) = try await networkManager.data(for: URLRequest(url: endpoint))
        guard let http = response as? HTTPURLResponse, 200..<300 ~= http.statusCode else {
            throw PortfolioServiceError.invalidResponse
        }
        return try JSONDecoder().decode(Portfolio.self, from: data)
    }
}
