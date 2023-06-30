import Foundation

public protocol TransferSuccessRoutingLogic {
    func routeToPixArea()
}

public protocol ViewToPresenterTransferSuccess {
    func updateUI()
    func goToPixArea()
}
