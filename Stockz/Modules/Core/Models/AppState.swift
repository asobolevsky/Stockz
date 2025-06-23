import Foundation

struct AppState: Equatable {
    var user: User = .init(name: "John Doe")
    var portfolio: Portfolio = .init()
}
