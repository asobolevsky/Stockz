import SwiftUI

struct StockRowViewModel {
    let stock: Stock
    let theme: Theme
    
    var name: String {
        stock.name
    }
    
    var ticker: String {
        stock.ticker
    }

    var formattedPrice: String {
        NumberFormatter.priceFormatter(with: stock.currency)
            .string(from: NSNumber(value: stock.currentPrice)) ?? "-"
    }
    
    var priceDiff: String {
        NumberFormatter.percentFormatter
            .string(from: NSNumber(value: stock.priceDiff)) ?? "0%"
    }
    
    var priceDiffColor: Color {
        if stock.priceDiff > 0 {
            theme.positive
        } else if stock.priceDiff < 0 {
            theme.negative
        } else {
            theme.secondaryText
        }
    }
}
