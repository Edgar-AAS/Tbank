import UIKit
import Domain

public class HomeRouter {
    public weak var viewController: UIViewController?
    public var destinationController: UIViewController
    
    public init(viewController: UIViewController?, destinationController: UIViewController) {
        self.viewController = viewController
        self.destinationController = destinationController
    }
}

extension HomeRouter: PresenterToRouterHomeProtocol {
    public func goToProfile() {
        viewController?.navigationController?.pushViewController(destinationController, animated: true)
    }
}
