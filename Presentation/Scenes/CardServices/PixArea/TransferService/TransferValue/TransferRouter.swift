import Foundation
import UIKit

public final class TransferRouter {
    private weak var viewController: UIViewController?
    private let contactListFactory: (Double) -> ContactListToTransferController
    
    public init(viewController: UIViewController, contractListFactory: @escaping (Double) -> ContactListToTransferController) {
        self.viewController = viewController
        self.contactListFactory = contractListFactory
    }
}

extension TransferRouter: TransferRouterLogic {
    public func routeToContactListViewWith(currencyValue: Double) {
        viewController?.navigationController?.pushViewController(contactListFactory(currencyValue), animated: true)
    }
}
