import Foundation

struct HoldingsRowViewModel {
    let stock: Stock

    var name: String {
        stock.name
    }

    var ticker: String {
        stock.ticker
    }

    var totalPrice: String {
        let totalPrice = Double(stock.quantity ?? 0) * stock.currentPrice
        return NumberFormatter.priceFormatter(with: stock.currency).string(from: NSNumber(value: totalPrice)) ?? ""
    }

    var quantity: String {
        "\(stock.quantity ?? 0)"
    }
}
