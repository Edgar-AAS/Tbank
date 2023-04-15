import Foundation
import UIKit
import Domain

public class CardConfigurationRouter {
    private weak var viewController: UIViewController?
    
    public init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension CardConfigurationRouter: CardConfigurationRouterLogic {
    public func goToCardSuccessScreen(digitalCardModel: DigitalCardModel) {
        DispatchQueue.main.async  { [weak self] in
            let cardSuccessController = CardSuccessBuilder.build(digitalCardModel: digitalCardModel)
            self?.viewController?.navigationController?.pushViewController(cardSuccessController, animated: true)
        }
    }
}
