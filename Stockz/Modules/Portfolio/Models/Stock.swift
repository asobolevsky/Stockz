import Foundation

struct Portfolio: Decodable {
    var stocks: [Stock]
}

struct Stock: Decodable, Identifiable, Equatable {
    var id: String { ticker }
    let ticker: String
    let name: String
    let currency: String
    let currentPriceCents: Int
    let quantity: Int?
    let currentPriceTimestamp: Int

    enum CodingKeys: String, CodingKey {
        case ticker, name, currency
        case currentPriceCents = "current_price_cents"
        case quantity
        case currentPriceTimestamp = "current_price_timestamp"
    }
}

// MARK: - Price formating
extension Stock {
    var currentPrice: Double {
        Double(currentPriceCents) / 100.0
    }

    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        return formatter.string(from: NSNumber(value: currentPrice)) ?? "-"
    }
}

