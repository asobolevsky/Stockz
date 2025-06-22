import SwiftUI

struct StockListView: View {
    let stocks: [Stock]
    
    var body: some View {
        List(stocks) { stock in
            StockRowView(stock: stock)
        }
        .listStyle(.plain)
    }
}
