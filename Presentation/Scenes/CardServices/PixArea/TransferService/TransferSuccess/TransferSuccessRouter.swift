import Foundation
import UIKit

public class TransferSuccessRouter: TransferSuccessRoutingLogic {
    private weak var viewController: UIViewController?
    
    public init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    public func routeToPixArea() {
        guard let controller = viewController?.navigationController?.viewControllers.first(where: { $0 is PixAreaViewController }) else { return }
        viewController?.navigationController?.popToViewController(controller, animated: true)
    }
}
