import UIKit
import Data

public class LoginRouter {
    private weak var viewController: UIViewController?
    public let homeFactory: () -> HomeController
    
    public init(viewController: UIViewController, homeFactory: @escaping () -> HomeController) {
        self.viewController = viewController
        self.homeFactory = homeFactory
    }
}

extension LoginRouter: PresenterToRouterLoginProtocol {
    public func goToHome() {
        viewController?.navigationController?.pushViewController(homeFactory(), animated: true)
    }
}
