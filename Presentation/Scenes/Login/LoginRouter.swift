import UIKit
import Data

public class LoginRouter {
    private let navigationController: UINavigationController?
    private let homeFactory: () -> HomeController
    
    public init(navigationController: UINavigationController?, homeFactory: @escaping () -> HomeController) {
        self.navigationController = navigationController
        self.homeFactory = homeFactory
    }
}

extension LoginRouter: PresenterToRouterLoginProtocol {
    public func goToHome() {
        navigationController?.pushViewController(homeFactory(), animated: true)
    }
}
