import Foundation
import Domain
import Presentation

public func makeTransferControllerFactory(validatePixTransferService: ValidateBalance) -> TransferViewController {
    let controller = TransferViewController()
    let presenter = TransferPresenter(validatePixTransferService: validatePixTransferService, alertView: WeakVarProxy(controller))
    controller.presenter = presenter
    return controller
}
