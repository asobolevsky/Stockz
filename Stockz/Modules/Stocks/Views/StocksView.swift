import SwiftUI

struct StocksView: View {
    @StateObject private var viewModel: StocksViewModel = .init()

    var body: some View {
        NavigationStack {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationTitle("Stocks")
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
            StocksListView(viewModel: .init(stocks: stocks))
        }
    }
}
