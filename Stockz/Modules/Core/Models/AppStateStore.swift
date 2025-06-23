import Combine
import Foundation

final class AppStateStore: ObservableObject {
    static let shared = AppStateStore(state: .init())
    
    private let queue = DispatchQueue(label: "store.queue")
    private let storage: CurrentValueSubject<AppState, Never>

    init(state: AppState) {
        self.storage = CurrentValueSubject(state)
    }
}

extension AppStateStore {
    subscript<Value>(keyPath: WritableKeyPath<AppState, Value>) -> Value where Value: Equatable {
        get {
            queue.sync {
                storage.value[keyPath: keyPath]
            }
        }
        set {
            queue.sync {
                var copy = storage.value
                if copy[keyPath: keyPath] != newValue {
                    copy[keyPath: keyPath] = newValue
                    storage.value = copy
                }
            }
        }
    }

    func select<Value>(
        _ keyPath: WritableKeyPath<AppState, Value>
    ) -> AnyPublisher<Value, Never> where Value: Equatable {
        queue.sync {
            storage
                .map(keyPath)
                .removeDuplicates()
                .eraseToAnyPublisher()
        }
    }

    func update(_ update: (inout AppState) -> Void) {
        queue.sync {
            var copy = storage.value
            update(&copy)
            if copy != storage.value {
                storage.value = copy
            }
        }
    }
}
