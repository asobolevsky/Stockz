import SwiftUI

struct ErrorView: View {
    let message: String
    let retryAction: () async -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text("Error: \(message)")
            Button("Retry") {
                Task { await retryAction() }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}
