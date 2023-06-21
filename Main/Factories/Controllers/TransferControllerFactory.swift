import Foundation
import Domain
import Presentation

public func makeTransferControllerFactory(validatePixTransferService: ValidateBalance, updateBalance: UpdateBalance) -> TransferViewController {
    let controller = TransferViewController()
    let router = TransferRouter(viewController: controller, contractListFactory: contactListFactory)
    let presenter = TransferPresenter(validatePixTransferService: validatePixTransferService,
                                      alertView: WeakVarProxy(controller),
                                      updateBalance: updateBalance,
                                      updateBalanceView: WeakVarProxy(controller),
                                      router: router)
    controller.presenter = presenter
    return controller
}
