import SwiftUI

struct HoldingsView: View {
    @Environment(\.theme) private var theme
    @StateObject var viewModel: HoldingsViewModel = .init()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let totalValue = viewModel.totalValueFormatted {
                    Text(totalValue)
                        .font(.system(size: 40, weight: .medium))
                }
                holdings
            }
            .navigationTitle("Holdings")
            .background(theme.background)
        }
        .task {
            await viewModel.load()
        }
        .navigationTitle("Holdings")
    }
    
    @ViewBuilder
    private var holdings: some View {
        switch viewModel.state {
        case .idle, .loading:
            LoadingView(text: "Loading…")
        case .failed(let error):
            Text("Unexpected error: \(error)")
        case .loaded(let holdings):
            StocksListView(viewModel: .init(stocks: holdings))
        }
    }
}
