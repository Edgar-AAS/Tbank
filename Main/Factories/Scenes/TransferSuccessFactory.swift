import Foundation
import Presentation
import Domain

let makeTransferSuccessFactory: (ContactToTransferModel) -> TransferSuccessViewController = { contact in
    let controller = makeTransferSuccessViewControllerFactory(contactModel: contact)
    return controller
}
