import UIKit

public class HomeRouter {
    private weak var viewController: UIViewController?
    
    public init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}

extension HomeRouter: PresenterToRouterHomeProtocol {
    public func goToProfile() {
        let profileController = ProfileController()
        viewController?.navigationController?.pushViewController(profileController, animated: true)
    }
}
