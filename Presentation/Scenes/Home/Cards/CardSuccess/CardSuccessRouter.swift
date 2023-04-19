import Foundation
import Domain
import UIKit

public class CardSuccessRouter {
    private weak var viewController: UIViewController?
    private let cardInformationFactory: (DigitalCardModel) -> CardInformationViewController
    
    public init(viewController: UIViewController, cardInformationFactory: @escaping (DigitalCardModel) -> CardInformationViewController) {
        self.viewController = viewController
        self.cardInformationFactory = cardInformationFactory
    }
}

extension CardSuccessRouter: CardSuccessRoutingLogic {
    public func routeToCardView() {
        guard let controller = viewController?.navigationController?.viewControllers.first(where: { $0 is CardsViewController }) else { return }
        viewController?.navigationController?.popToViewController(controller, animated: true)
    }
    
    public func routeToCardInfo(digitalCardModel: DigitalCardModel) {
        viewController?.navigationController?.pushViewController(cardInformationFactory(digitalCardModel), animated: true)
    }
}
    
