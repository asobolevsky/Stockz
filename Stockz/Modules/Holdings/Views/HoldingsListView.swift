import SwiftUI

struct HoldingsListView: View {
    @StateObject private var viewModel: HoldingsListViewModel = .init()

    var body: some View {
        List(viewModel.stocks) {
            HoldingsRowView(viewModel: .init(stock: $0))
        }
    }
}
