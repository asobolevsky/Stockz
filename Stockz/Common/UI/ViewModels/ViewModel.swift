import Foundation

enum ViewModelState<T: Equatable, E: Error>: Equatable {
    case idle
    case loading
    case loaded(T)
    case failed(E)

    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loading, .loading):
            return true
        case (.loaded(let lhsStocks), .loaded(let rhsStocks)):
            return lhsStocks == rhsStocks
        case (.failed(let lhsError), .failed(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}

protocol ViewModel: AnyObject {
    associatedtype T: Equatable
    associatedtype E: Error
    
    var state: ViewModelState<T, E> { get set }

    func load() async
}

extension ViewModel {
    @MainActor
    func updateState(_ state: ViewModelState<T, E>) async {
        self.state = state
    }
}
