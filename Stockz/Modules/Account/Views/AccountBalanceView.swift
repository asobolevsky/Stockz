import SwiftUI

struct AccountBalanceView: View {
    @Environment(\.theme) private var theme
    let balance: Balance
    
    var body: some View {
        VStack {
            Text("Current ballance")
                .font(.system(size: 22))
                .padding(.bottom, 4)
            Text(balance.formattedPrice)
                .font(.system(size: 40, weight: .medium))
            Button(action: {}) {
                Text("Add Funds")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .background(theme.accent)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(theme.background)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding()
    }
}
