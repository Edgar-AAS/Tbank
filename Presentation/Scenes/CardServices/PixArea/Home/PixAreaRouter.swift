import Foundation
import UIKit

public final class PixAreaRouter {
    private weak var viewController: UIViewController?
    private let transferViewControllerFactory: () -> TransferViewController
    
    public init(viewController: UIViewController, transferViewControllerFactory: @escaping () -> TransferViewController) {
        self.viewController = viewController
        self.transferViewControllerFactory = transferViewControllerFactory
    }
}

extension PixAreaRouter: PixAreaRoutingLogic {
    public func routeToServiceWith(tag: Int) {
        switch tag {
        case 0:
            viewController?.navigationController?.pushViewController(transferViewControllerFactory(), animated: true)
        default:
            print("Serviço não implementado")
        }
    }
}

