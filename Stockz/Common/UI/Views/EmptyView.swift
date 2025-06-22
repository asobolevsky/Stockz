import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("No stocks available.")
            Text("Please check back later.")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}
