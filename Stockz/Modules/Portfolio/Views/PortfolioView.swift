import SwiftUI

struct PortfolioView: View {
    @StateObject private var viewModel: PortfolioViewModel = .init()

    var body: some View {
        NavigationView {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationTitle("My Portfolio")
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
        case .loaded(let stocks):
            if stocks.isEmpty {
                emptyContent
            } else {
                StockListView(stocks: stocks)
            }
        }
    }
    
    @ViewBuilder
    private var emptyContent: some View {
        VStack(spacing: 12) {
            Text("Your portfolio is empty.")
        }
    }
}
