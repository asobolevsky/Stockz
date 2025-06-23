import SwiftUI

struct AddFundsSheet: View {
    @Environment(\.theme) private var theme
    @Binding var amount: String
    let onAdd: () -> Void
    let onCancel: () -> Void
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Add Funds")
                    .foregroundColor(theme.primaryText)
                    .font(.system(size: 22, weight: .semibold))
                
                Text("Enter the amount you want to add to your account.")
                    .foregroundColor(theme.secondaryText)
                    .multilineTextAlignment(.center)
                
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Spacer()
            }
            .background(theme.background)
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel", action: onCancel),
                trailing: Button("Add") {
                    onAdd()
                }
                .disabled(amount.isEmpty || Double(amount) == nil)
            )
        }
    }
}