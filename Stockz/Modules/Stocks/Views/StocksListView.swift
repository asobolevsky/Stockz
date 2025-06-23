import SwiftUI

struct StocksListView: View {
    @Environment(\.theme) private var theme
    @StateObject var viewModel: StockListViewModel
    
    var body: some View {
        List(viewModel.stocks) {
            StocksRowView(viewModel: .init(stock: $0, theme: theme))
        }
        .overlay {
            emptyContent
        }
        .listStyle(.plain)
        .searchable(text: $viewModel.searchText, prompt: "Search stocks")
    }
    
    @ViewBuilder
    private var emptyContent: some View {
        if viewModel.stocks.isEmpty {
            VStack(spacing: 12) {
                if viewModel.searchText.isEmpty {
                    Text("No stocks to display")
                } else {
                    Text("Could not find stocks with this query")
                }
            }
        }
    }
}
