import SwiftUI

struct AccountView: View {
    @Environment(\.theme) private var theme
    @StateObject private var viewModel: AccountViewModel = .init()
    @State private var showAddFundsSheet = false
    @State private var fundsAmount = ""
    
    var body: some View {
        NavigationStack {
            content
                .background(theme.background)
        }
        .task {
            await viewModel.load()
        }
        .sheet(isPresented: $showAddFundsSheet) {
            AddFundsSheet(
                amount: $fundsAmount,
                onAdd: {
                    if let amount = Double(fundsAmount) {
                        Task {
                            await viewModel.addFunds(amount: amount)
                        }
                    }
                    showAddFundsSheet = false
                    fundsAmount = ""
                },
                onCancel: {
                    showAddFundsSheet = false
                    fundsAmount = ""
                }
            )
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            LoadingView(text: "Loading…")
        case .failed(let message):
            ErrorView(message: "Error: \(message)") {
                await viewModel.load()
            }
        case .loaded(let accountInfo):
            ScrollView {
                VStack(spacing: 0) {
                    AccountUserView(user: accountInfo.user)
                    AccountBalanceView(balance: accountInfo.portfolio.balance) {
                        showAddFundsSheet = true
                    }
                    AccountTransactionHistoryView(transactions: accountInfo.portfolio.transactions)
                }
            }
        }
    }
}

#Preview {
    AccountView()
}
