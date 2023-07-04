import UIKit
import Domain

public class ContactListRouter {
    private weak var viewController: UIViewController?
    private var preTransferFactory: (ContactToTransferModel) -> PreTransferViewController
    
    public init(viewController: UIViewController?, preTransferFactory: @escaping (ContactToTransferModel) -> PreTransferViewController) {
        self.viewController = viewController
        self.preTransferFactory = preTransferFactory
    }
}

extension ContactListRouter: ContactListRoutingLogic {
    public func routeToPreTransferWith(contact: ContactToTransferModel) {
        viewController?.navigationController?.pushViewController(preTransferFactory(contact), animated: true)
    }
}
