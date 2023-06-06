import Foundation
import UIKit
import Domain

public class CardConfigurationRouter {
    private weak var viewController: UIViewController?
    private let cardSuccessFactory: (UserCard) -> CardSuccessViewController
    
    public init(viewController: UIViewController, cardSuccessFactory: @escaping (UserCard) -> CardSuccessViewController) {
        self.viewController = viewController
        self.cardSuccessFactory = cardSuccessFactory
    }
}

extension CardConfigurationRouter: CardConfigurationRouterLogic {
    public func goToCardSuccessScreen(userCardModel: UserCard) {
        if let controller = viewController {
            DispatchQueue.main.async  { [weak self] in
                guard let self = self else { return }
                controller.navigationController?.pushViewController(self.cardSuccessFactory(userCardModel), animated: true)
            }
        }
    }
}
