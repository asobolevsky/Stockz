import SwiftUI

struct AccountTransactionHistoryView: View {
    @Environment(\.theme) private var theme
    let transactions: [Transaction]
    
    var body: some View {
        VStack {
            Text("Recent Transactions")
                .font(.system(size: 22))
                .padding(.bottom, 8)
            if transactions.isEmpty {
                    Text("You don't have any transactions yet.")
                        .font(.system(size: 18))
            } else {
                ForEach(transactions) { transaction in
                    AccountTransactionRowView(transaction: transaction)
                        .padding(.vertical, 2)
                    if transaction != transactions.last {
                        Divider()
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(theme.background)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding()
    }
}

struct AccountTransactionRowView: View {
    let transaction: Transaction
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(transaction.title)
                    .font(.headline)
                Text(transaction.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.subheadline)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(transaction.formattedAmount)
                    .font(.headline)
                    .foregroundColor(transaction.isPositive ? .green : .red)
                Text(transaction.status.rawValue)
                    .font(.subheadline)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    AccountTransactionHistoryView(
        transactions: [
            .init(id: UUID(), type: .deposit(amount: 1000), date: Date(), status: .completed),
            .init(id: UUID(), type: .buy(ticker: "AAPL", shares: 10, price: 150), date: Date(), status: .pending),
            .init(id: UUID(), type: .sell(ticker: "FOO", shares: 5, price: 160), date: Date(), status: .completed),
            .init(id: UUID(), type: .deposit(amount: 500), date: Date(), status: .failed),
        ]
    )
}
