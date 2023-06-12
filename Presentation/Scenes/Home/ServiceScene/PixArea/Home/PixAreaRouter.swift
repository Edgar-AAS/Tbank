import Foundation
import UIKit

public final class PixAreaRouter {
    private weak var viewController: UIViewController?
    
    public init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension PixAreaRouter: PixAreaRoutingLogic {
    public func routeToServiceWith(tag: Int) {
        switch tag {
        case 0:
            viewController?.navigationController?.pushViewController(TransferViewController(), animated: true)
        default:
            print("falha")
        }
    }
}

