import Foundation

struct Stock: Codable, Identifiable, Equatable {
    var id: String { ticker }
    let ticker: String
    let name: String
    let currency: String
    let currentPriceCents: Int
    var quantity: Int?
    let currentPriceTimestamp: Int
    var priceDiff: Double = 0

    enum CodingKeys: String, CodingKey {
        case ticker, name, currency
        case currentPriceCents = "current_price_cents"
        case quantity
        case currentPriceTimestamp = "current_price_timestamp"
    }
}

extension Stock {
    var currentPrice: Double {
        Double(currentPriceCents) / 100.0
    }
    
    var sharesQuantity: Int {
        quantity ?? 0
    }
    
    var formattedPrice: String {
        NumberFormatter.priceFormatter(with: currency)
            .string(from: NSNumber(value: currentPrice)) ?? "-"
    }
}
