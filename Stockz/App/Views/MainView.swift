import SwiftUI

struct MainView: View {
    @Environment(\.theme) private var theme
    @State private var selectedTab: Int = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            StocksView()
                .tabItem {
                    Label("Stocks", systemImage: "chart.bar")
                }
                .tag(0)

            HoldingsView()
                .tabItem {
                    Label("Portfolio", systemImage: "case")
                }
                .tag(1)

            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person")
                }
                .tag(2)
        }
        .accentColor(theme.accent)
        .environment(\.theme, Theme())
    }
}
