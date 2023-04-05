import Foundation
import UIKit

public class CardsRouter {
    public weak var viewController: UIViewController?
    public var destinationController: UIViewController
    
    public init(viewController: UIViewController, destinationController: UIViewController) {
        self.viewController = viewController
        self.destinationController = destinationController
    }
}

extension CardsRouter: CardRoutingLogic {
    public func goToCardCreationNavigation() {
        if let controller = viewController {
            controller.navigationController?.pushViewController(destinationController, animated: true)
        }
    }
}
