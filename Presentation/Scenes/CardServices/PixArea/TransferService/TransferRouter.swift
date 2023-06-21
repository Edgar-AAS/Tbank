import Foundation
import UIKit

public final class TransferRouter {
    private weak var viewController: UIViewController?
    private let contractListFactory: (Double) -> ContactListToTransferController
    
    public init(viewController: UIViewController, contractListFactory: @escaping (Double) -> ContactListToTransferController) {
        self.viewController = viewController
        self.contractListFactory = contractListFactory
    }
}

extension TransferRouter: TransferRouterLogic {
    public func routeToContactListViewWith(currencyValue: Double) {
        viewController?.navigationController?.pushViewController(contractListFactory(currencyValue), animated: true)
    }
}
