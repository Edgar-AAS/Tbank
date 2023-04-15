import UIKit
import Domain
import Data
public class HomeRouter {
    public weak var viewController: UIViewController? //closure
    private var destinationController: UIViewController?
    private var cardsControllerFactory: () -> CardsViewController
    private var profileControllerFactory: () -> ProfileController
    
    public init(viewController: UIViewController?, profileControllerFactory: @escaping () -> ProfileController, cardsControllerFactory: @escaping () -> CardsViewController) {
        self.viewController = viewController
        self.cardsControllerFactory = cardsControllerFactory
        self.profileControllerFactory = profileControllerFactory
    }
}

extension HomeRouter: PresenterToRouterHomeProtocol {
    public func goToProfile() {
        viewController?.navigationController?.pushViewController(profileControllerFactory(), animated: true)
    }

    public func goToCardsController() {
        viewController?.navigationController?.pushViewController(cardsControllerFactory(), animated: true)
    }
}
