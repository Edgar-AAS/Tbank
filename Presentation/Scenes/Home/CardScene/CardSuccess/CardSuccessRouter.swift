import Foundation
import Domain
import UIKit

public class CardSuccessRouter {
    private weak var viewController: UIViewController?
    private let cardInformationFactory: (UserCard) -> CardInformationViewController
    
    public init(viewController: UIViewController, cardInformationFactory: @escaping (UserCard) -> CardInformationViewController) {
        self.viewController = viewController
        self.cardInformationFactory = cardInformationFactory
    }
}

extension CardSuccessRouter: CardSuccessRoutingLogic {
    public func routeToCardView() {
        guard let controller = viewController?.navigationController?.viewControllers.first(where: { $0 is CardsViewController }) else { return }
        viewController?.navigationController?.popToViewController(controller, animated: true)
    }
    
    public func routeToCardInfo(userCardModel: UserCard) {
        viewController?.navigationController?.pushViewController(cardInformationFactory(userCardModel), animated: true)
    }
}
    
