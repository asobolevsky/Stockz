import Foundation

struct StocksListAPIResponse: Decodable {
    let stocks: [Stock]
}
