import SwiftUI

struct StockRowViewModel {
    let stock: Stock
    let theme: Theme
    
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
