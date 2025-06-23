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
        let totalPrice = Double(stock.sharesQuantity) * stock.currentPrice
        return NumberFormatter.priceFormatter(with: stock.currency).string(from: NSNumber(value: totalPrice)) ?? ""
    }
}
