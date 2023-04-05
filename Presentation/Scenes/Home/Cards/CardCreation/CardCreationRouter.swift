import Foundation
import UIKit

public class CardCreationRouter {
    weak var viewController: UIViewController?
    public var cardConfigurationViewController: UIViewController
    
    public init(viewController: UIViewController, cardConfigurationViewController: UIViewController) {
        self.viewController = viewController
        self.cardConfigurationViewController = cardConfigurationViewController
    }
}

extension CardCreationRouter: CardCreationRoutingLogic {
    public func goToCardConfiguration() {
        viewController?.navigationController?.pushViewController(cardConfigurationViewController, animated: true)
    }
}
