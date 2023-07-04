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
        viewController?.navigationController?.pushViewController(cardSuccessFactory(userCardModel), animated: true)
    }
}
