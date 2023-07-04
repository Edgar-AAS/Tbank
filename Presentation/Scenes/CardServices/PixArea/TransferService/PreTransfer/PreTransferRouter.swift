import Foundation
import Domain
import UIKit

public class PreTransferRouter {
    private weak var viewController: UIViewController?
    private let preTransferSuccessFactory: (ContactToTransferModel) -> TransferSuccessViewController
    
    public init(viewController: UIViewController, transferSuccessFactory: @escaping (ContactToTransferModel) -> TransferSuccessViewController) {
        self.viewController = viewController
        self.preTransferSuccessFactory = transferSuccessFactory
    }
}

extension PreTransferRouter: PreTransferRoutingLogic {
    public func routeToTransferSuccessView(contact: ContactToTransferModel) {
        viewController?.navigationController?.pushViewController(preTransferSuccessFactory(contact), animated: true)
    }
}
