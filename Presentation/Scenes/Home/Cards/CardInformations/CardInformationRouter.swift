import Foundation
import UIKit

public class CardInformationRouter: CardInformationRoutingLogic {
    private weak var viewController: UIViewController?
    
    public init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    public func popToCardController() {
        guard let controller = viewController?.navigationController?.viewControllers.first(where: { $0 is CardsViewController }) else { return }
        viewController?.navigationController?.popToViewController(controller, animated: true)
    }
}
