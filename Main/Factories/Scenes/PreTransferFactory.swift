import Foundation
import Domain
import Presentation

let makePreTransferFactory: (ContactToTransferModel) -> PreTransferViewController = { contact in
    let controller = makePreTransferControllerFactory(contactModel: contact)
    return controller
}
