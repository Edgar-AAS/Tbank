import Foundation
import UIKit
import Domain

public class CardsRouter {
    public weak var viewController: UIViewController?
    public var cardCreationFactory: () -> CardCreationViewController
    public var cardInformationFactory: (UserCard) -> CardInformationViewController
    
    public init(viewController: UIViewController,
                cardCreationFactory: @escaping () -> CardCreationViewController,
                cardInformationFactory: @escaping (UserCard) -> CardInformationViewController)
    {
        self.viewController = viewController
        self.cardCreationFactory = cardCreationFactory
        self.cardInformationFactory = cardInformationFactory
    }
}

extension CardsRouter: CardRoutingLogic {
    public func goToCardInformationScreenWith(userCard: UserCard) {
        if let controller = viewController {
            controller.navigationController?.pushViewController(cardInformationFactory(userCard), animated: true)
        }
    }
    
    public func goToCardCreationNavigation() {
        if let controller = viewController {
            controller.navigationController?.pushViewController(cardCreationFactory(), animated: true)
        }
    }
}
