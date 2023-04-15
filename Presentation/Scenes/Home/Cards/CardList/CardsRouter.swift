import Foundation
import UIKit
import Domain

public class CardsRouter {
    public weak var viewController: UIViewController?
    public var cardCreationFactory: () -> CardCreationViewController
    
    public init(viewController: UIViewController, cardCreationFactory: @escaping () -> CardCreationViewController) {
        self.viewController = viewController
        self.cardCreationFactory = cardCreationFactory
    }
}

extension CardsRouter: CardRoutingLogic {
    public func goToCardInformationScreenWith(userCard: UserCard) {
        if let controller = viewController {
            let userCardMapped = DigitalCardModel(name: userCard.name,
                                                  isVirtual: userCard.isVirtual,
                                                  balance: userCard.balance,
                                                  cardFlag: userCard.cardFlag,
                                                  cardTag: userCard.cardTag,
                                                  cardBrandImageUrl: userCard.cardBrandImageURL,
                                                  cardNumber: userCard.cardNumber,
                                                  cardExpirationDate: userCard.cardExpirationDate,
                                                  cardFunction: userCard.cardFunction,
                                                  cvc: userCard.cvc)
            let cardInformationController = CardInformationBuilder.build(digitalCardModel: userCardMapped)
            controller.navigationController?.pushViewController(cardInformationController, animated: true)
        }
    }
    
    public func goToCardCreationNavigation() {
        if let controller = viewController {
            controller.navigationController?.pushViewController(cardCreationFactory(), animated: true)
        }
    }
}
