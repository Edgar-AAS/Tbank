import Foundation
import Domain
import Presentation

public func makeTransferControllerFactory(validatePixTransferService: ValidateBalance, fetchBalance: FetchBalance) -> TransferViewController {
    let controller = TransferViewController()
    let router = TransferRouter(viewController: controller, contractListFactory: contactListFactory)
    let presenter = TransferPresenter(validateBalance: validatePixTransferService,
                                      alertView: WeakVarProxy(controller),
                                      fetchAvaiableBalance: fetchBalance,
                                      updateBalanceView: WeakVarProxy(controller),
                                      router: router)
    controller.presenter = presenter
    return controller
}
