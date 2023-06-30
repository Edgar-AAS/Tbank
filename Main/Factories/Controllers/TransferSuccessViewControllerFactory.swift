import Foundation
import Domain
import Presentation

func makeTransferSuccessViewControllerFactory(contactModel: ContactToTransferModel) -> TransferSuccessViewController {
    let controller = TransferSuccessViewController()
    let router = TransferSuccessRouter(viewController: controller)
    let presenter = TransferSuccessPresenter(contact: contactModel, updateTransferView: controller, router: router)
    controller.presenter = presenter
    return controller
}
