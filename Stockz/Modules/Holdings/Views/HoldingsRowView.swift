import SwiftUI

struct HoldingsRowView: View {
    @Environment(\.theme) private var theme
    let viewModel: HoldingsRowViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.name)
                    .font(.headline)
                    .foregroundColor(theme.primaryText)
                Text(viewModel.ticker)
                    .font(.subheadline)
                    .foregroundColor(theme.secondaryText)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text(viewModel.totalPrice)
                    .font(.system(size: 16, weight: .medium))
                Text(viewModel.quantity)
                    .font(.caption)
                    .foregroundColor(theme.secondaryText)
            }
        }
    }
}
