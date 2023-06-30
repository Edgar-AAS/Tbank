import Foundation
import Domain
import Presentation

func makePreTransferControllerFactory(contactModel: ContactToTransferModel) -> PreTransferViewController {
    let controller = PreTransferViewController()
    let router = PreTransferRouter(viewController: controller, transferSuccessFactory: makeTransferSuccessFactory)
    let presenter = PreTransferPresenter(contactModel: contactModel, updateTransferView: controller, router: router)
    controller.presenter = presenter
    return controller
}
