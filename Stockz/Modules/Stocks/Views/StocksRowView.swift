import SwiftUI

struct StocksRowView: View {
    @Environment(\.theme) private var theme
    
    let viewModel: StockRowViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.stock.name)
                    .font(.headline)
                    .foregroundColor(theme.primaryText)
                Text(viewModel.stock.ticker)
                    .font(.subheadline)
                    .foregroundColor(theme.secondaryText)
                if viewModel.stock.sharesQuantity > 0 {
                    Text("Quantity: \(viewModel.stock.sharesQuantity)")
                        .font(.caption)
                        .foregroundColor(theme.secondaryText)
                }
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text(viewModel.stock.formattedPrice)
                    .font(.system(size: 16, weight: .medium))
                Text(viewModel.priceDiff)
                    .font(.caption)
                    .foregroundColor(viewModel.priceDiffColor)
            }
        }
        .padding(.vertical, 4)
    }
}
