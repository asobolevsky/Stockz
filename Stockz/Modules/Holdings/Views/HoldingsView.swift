import SwiftUI

struct HoldingsView: View {
    var body: some View {
        NavigationStack {
            HoldingsListView()
        }
        .navigationTitle(Text("My Portfolio"))
        .task {
            
        }
    }
}
