import Foundation
import Domain

public protocol ViewToPresenterPreTransfer {
    func callsPreTransferData()
    func goToTransferSuccessView()
}

public protocol PreTransferRoutingLogic {
    func routeToTransferSuccessView(contact: ContactToTransferModel)
}
