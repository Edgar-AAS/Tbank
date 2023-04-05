import UIKit
import Domain
import Data
public class HomeRouter {
    public weak var viewController: UIViewController? //closure
    private var destinationController: UIViewController?
    private var cardsViewController: UIViewController?
    
    public init(viewController: UIViewController?, destinationController: UIViewController, cardsViewController: UIViewController) {
        self.viewController = viewController
        self.destinationController = destinationController
        self.cardsViewController = cardsViewController
    }
}

extension HomeRouter: PresenterToRouterHomeProtocol {
    public func goToProfile() {
        if let destinationVC = destinationController {
            viewController?.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    
    public func goToCardsController() {
        if let cardsController = cardsViewController {
            viewController?.navigationController?.pushViewController(cardsController, animated: true)
        }
    }
}
