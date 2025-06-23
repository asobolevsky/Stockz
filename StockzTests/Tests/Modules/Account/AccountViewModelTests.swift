import Combine
import XCTest
@testable import Stockz

final class AccountViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()

    func testAccountInfoLoadedCorrectly() async {
        let store = AppStateStore(state: .init(
            user: User(name: "John Doe"), 
            portfolio: .init(balance: .init(currency: "USD", amount: 1000))
        ))
        let viewModel = AccountViewModel(store: store)

        let expectation = XCTestExpectation(description: "Load account info")
        viewModel.$state
            .compactMap { state -> AccountInfo? in
                if case let .loaded(accountInfo) = state {
                    return accountInfo
                }
                return nil
            }
            .sink { accountInfo in
                XCTAssertEqual(accountInfo.user.name, "John Doe")
                XCTAssertEqual(accountInfo.portfolio.balance.amount, 1000)
                XCTAssertEqual(accountInfo.portfolio.balance.currency, "USD")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        await viewModel.load()
        await fulfillment(of: [expectation], timeout: 1)
    }

    func testAddFunds() async {
        let store = AppStateStore(state: .init(portfolio: .init(balance: .init(currency: "USD", amount: 1000))))
        let viewModel = AccountViewModel(store: store)

        let expectation = XCTestExpectation(description: "Add funds")
        viewModel.$state
            .compactMap { state -> AccountInfo? in
                if case let .loaded(accountInfo) = state {
                    return accountInfo
                }
                return nil
            }
            .dropFirst()
            .sink { accountInfo in
                XCTAssertEqual(accountInfo.portfolio.balance.amount, 1100)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        await viewModel.load()
        await viewModel.addFunds(amount: 100)

        await fulfillment(of: [expectation], timeout: 1)
    }
}
