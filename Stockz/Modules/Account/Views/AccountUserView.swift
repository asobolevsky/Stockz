import SwiftUI

struct AccountUserView: View {
    @Environment(\.theme) private var theme
    let user: User
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "person.fill")
                .font(.system(size: 48))
                .frame(width: 100, height: 100)
                .background(theme.background)
                .clipShape(Circle())
                .overlay(Circle().stroke(.black, lineWidth: 1))
                .padding()
            
            Text(user.name)
                .font(.title)
                .padding()
        }
    }
}
