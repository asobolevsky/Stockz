import SwiftUI

struct AccountView: View {
    @Environment(\.theme) private var theme
    @StateObject private var viewModel: AccountViewModel = .init()
    
    var body: some View {
        NavigationStack {
            content
                .background(theme.background)
        }
        .task {
            await viewModel.load()
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
                    AccountBalanceView(balance: accountInfo.portfolio.balance)
                    AccountTransactionHistoryView(transactions: accountInfo.portfolio.transactions)
                }
            }
        }
    }
}

#Preview {
    AccountView()
}
