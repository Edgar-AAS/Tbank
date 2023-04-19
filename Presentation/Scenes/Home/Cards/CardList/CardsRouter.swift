import Foundation
import UIKit
import Domain

public class CardsRouter {
    public weak var viewController: UIViewController?
    public var cardCreationFactory: () -> CardCreationViewController
    public var cardInformationFactory: (DigitalCardModel) -> CardInformationViewController
    
    public init(viewController: UIViewController,
                cardCreationFactory: @escaping () -> CardCreationViewController,
                cardInformationFactory: @escaping (DigitalCardModel) -> CardInformationViewController)  
    {
        self.viewController = viewController
        self.cardCreationFactory = cardCreationFactory
        self.cardInformationFactory = cardInformationFactory
    }
}

extension CardsRouter: CardRoutingLogic {
    public func goToCardInformationScreenWith(userCard: UserCard) {
        if let controller = viewController {
            if let userCardJson = try? JSONEncoder().encode(userCard), let userCardMapped = try? JSONDecoder().decode(DigitalCardModel.self, from: userCardJson) {
                controller.navigationController?.pushViewController(cardInformationFactory(userCardMapped), animated: true)
            }
        }
    }
    
    public func goToCardCreationNavigation() {
        if let controller = viewController {
            controller.navigationController?.pushViewController(cardCreationFactory(), animated: true)
        }
    }
}
