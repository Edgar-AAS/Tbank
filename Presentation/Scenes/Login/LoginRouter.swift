import UIKit
import Data

public class LoginRouter {
    private weak var viewController: UIViewController?
    private let destinationController: UIViewController
    
    public init(viewController: UIViewController?, destinationController: UIViewController) {
        self.viewController = viewController
        self.destinationController = destinationController
    }
}

extension LoginRouter: PresenterToRouterLoginProtocol {
    public func goToHome() {
        viewController?.navigationController?.pushViewController(destinationController, animated: true)
    }
}   
