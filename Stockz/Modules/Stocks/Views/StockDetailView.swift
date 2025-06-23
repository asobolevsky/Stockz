import SwiftUI

struct StockDetailView: View {
    @Environment(\.theme) private var theme
    @StateObject private var viewModel: StockDetailViewModel = .init()
    @State private var shareCountForTransaction = 0
    
    let stock: Stock
    
    var body: some View {
        VStack {
            Text(stock.name)
                .font(.title)
                .foregroundColor(theme.primaryText)
            
            Text(stock.ticker)
                .font(.subheadline)
                .foregroundColor(theme.secondaryText)
            
            HStack {
                Text("Price")
                    .foregroundColor(theme.secondaryText)
                
                Text(stock.formattedPrice)
                    .foregroundColor(theme.primaryText)
            }
            .font(.system(size: 16, weight: .medium))
            
            if stock.sharesQuantity > 0 {
                HStack {
                    Text("Quantity")
                        .foregroundColor(theme.secondaryText)
                    
                    Text("\(stock.sharesQuantity)")
                        .foregroundColor(theme.primaryText)
                }
            }
            
            VStack {
                TextField("Share count", value: $shareCountForTransaction, format: .number)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                HStack {
                    Button(action: {
                        viewModel.buy(stock: stock, shareCount: shareCountForTransaction)
                    }) {
                        Text("Buy")
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(theme.positive)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    Button(action: {
                        viewModel.sell(stock: stock, shareCount: shareCountForTransaction)
                    }) {
                        Text("Sell")
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(theme.negative)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
                .accentColor(.white)
            }
        }
        .navigationTitle(stock.name)
        .padding()
        .background(theme.background)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding()
        .alert(isPresented: .constant(viewModel.errorMessage != nil)) {
            Alert(
                title: Text("Error"), 
                message: Text(viewModel.errorMessage ?? ""), 
                dismissButton: .default(Text("OK")) {
                    viewModel.errorMessage = nil
                }
            )
        }
    }
}
