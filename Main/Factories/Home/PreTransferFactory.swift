import Foundation
import Domain
import Presentation

let makePreTransferFactory: (ContactModel, String) -> PreTransferViewController = { contact, balance in
    let controller = PreTransferViewController()
    let presenter = PreTransferPresenter(contact: contact, valueToTransfer: balance, updateTransferView: controller)
    controller.presenter = presenter
    return controller
}
