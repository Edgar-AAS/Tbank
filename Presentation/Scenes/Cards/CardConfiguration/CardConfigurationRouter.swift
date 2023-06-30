import Foundation
import UIKit
import Domain

public class CardConfigurationRouter {
    private weak var viewController: UIViewController?
    private let cardSuccessFactory: (Card) -> CardSuccessViewController
    
    public init(viewController: UIViewController, cardSuccessFactory: @escaping (Card) -> CardSuccessViewController) {
        self.viewController = viewController
        self.cardSuccessFactory = cardSuccessFactory
    }
}

extension CardConfigurationRouter: CardConfigurationRouterLogic {
    public func goToCardSuccessScreen(userCardModel: Card) {
        if let controller = viewController {
            DispatchQueue.main.async  { [weak self] in
                guard let self = self else { return }
                controller.navigationController?.pushViewController(self.cardSuccessFactory(userCardModel), animated: true)
            }
        }
    }
}
