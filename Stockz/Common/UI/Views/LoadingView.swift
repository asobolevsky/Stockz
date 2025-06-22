import SwiftUI

struct LoadingView: View {
    var text = "Loading…"
    
    var body: some View {
        VStack {
            ProgressView(text)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
