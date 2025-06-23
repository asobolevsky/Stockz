import Foundation

struct Balance: Equatable, Codable {
    let currency: String
    var amount: Double
}

extension Balance {
    var formattedPrice: String {
        NumberFormatter.priceFormatter(with: currency)
            .string(from: NSNumber(value: amount)) ?? "-"
    }
}
