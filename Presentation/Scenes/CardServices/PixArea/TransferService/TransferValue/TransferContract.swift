import Foundation

public protocol ViewToPresenterTransferProtocol {
    func validateBalance(_ enteredValue: String)
    func fetchBalance()
}

public protocol TransferRouterLogic {
    func routeToContactListViewWith(currencyValue: Double)
}
