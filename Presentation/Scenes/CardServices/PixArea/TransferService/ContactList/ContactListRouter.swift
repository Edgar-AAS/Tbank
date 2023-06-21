import UIKit
import Domain

public class ContactListRouter {
    private weak var viewController: UIViewController?
    
    public init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}

extension ContactListRouter: ContactListRoutingLogic {
    public func routeToPreTransferWith(contact: ContactModel) {
        viewController?.navigationController?.pushViewController(UIViewController(), animated: true)
    }
}
