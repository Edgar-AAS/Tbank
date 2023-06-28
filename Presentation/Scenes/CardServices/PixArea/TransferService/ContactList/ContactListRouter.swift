import UIKit
import Domain

public class ContactListRouter {
    private weak var viewController: UIViewController?
    private var preTransferFactory: (ContactModel, String) -> PreTransferViewController
    
    public init(viewController: UIViewController?, preTransferFactory: @escaping (ContactModel, String) -> PreTransferViewController) {
        self.viewController = viewController
        self.preTransferFactory = preTransferFactory
    }
}

extension ContactListRouter: ContactListRoutingLogic {
    public func routeToPreTransferWith(contact: ContactModel, valueToTransfer: String) {
        viewController?.navigationController?.pushViewController(preTransferFactory(contact, valueToTransfer), animated: true)
    }
}
