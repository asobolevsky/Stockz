import SwiftUI

struct StockRowView: View {
    let stock: Stock

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(stock.ticker)
                    .font(.headline)
                Text(stock.name)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text(stock.formattedPrice)
                    .bold()
                if let qty = stock.quantity {
                    Text("Qty: \(qty)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 4)
    }
}
