import Foundation
import Domain
import Presentation

public func makeTransferControllerFactory(validatePixTransferService: ValidateBalance, updateBalance: UpdateBalance) -> TransferViewController {
    let controller = TransferViewController()
    let presenter = TransferPresenter(validatePixTransferService: validatePixTransferService,
                                      alertView: WeakVarProxy(controller),
                                      updateBalance: updateBalance,
                                      updateBalanceView: WeakVarProxy(controller))
    controller.presenter = presenter
    return controller
}
