import Foundation

public protocol ViewToPresenterTransferProtocol {
    func validateBalance(_ enteredValue: String)
    func fetchBalance()
}
