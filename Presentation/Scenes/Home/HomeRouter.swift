import UIKit
import Domain

public class HomeRouter {
    public weak var viewController: UIViewController?
    
    public init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}

extension HomeRouter: PresenterToRouterHomeProtocol {
    public func goToProfile(userModel: UserModelElement) {
        let profileController = ProfileController(style: .grouped)
        viewController?.navigationController?.pushViewController(profileController, animated: true)
    }
}
