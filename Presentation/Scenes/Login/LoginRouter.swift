import UIKit
import Data

public class LoginRouter {
    private weak var viewController: UIViewController?
    public let destinationController: UIViewController
    private let navigationController: UINavigationController?
    
    public init(navigationController: UINavigationController?, destinationController: UIViewController) {
        self.destinationController = destinationController
        self.navigationController = navigationController
    }
}

extension LoginRouter: PresenterToRouterLoginProtocol {
    public func goToHome() {
        navigationController?.pushViewController(destinationController, animated: true)
    }
}   
