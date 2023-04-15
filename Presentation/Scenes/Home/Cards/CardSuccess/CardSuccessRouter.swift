import Foundation
import Domain
import UIKit

public class CardSuccessRouter {
    private weak var viewController: UIViewController?
    
    public init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension CardSuccessRouter: CardSuccessRoutingLogic {
    public func routeToCardView() {
        guard let controller = viewController?.navigationController?.viewControllers.first(where: { $0 is CardsViewController }) else { return }
        viewController?.navigationController?.popToViewController(controller, animated: true)
    }
    
    public func routeToCardInfo(digitalCardModel: DigitalCardModel) {
        let cardInformationController = CardInformationBuilder.build(digitalCardModel: digitalCardModel)
        viewController?.navigationController?.pushViewController(cardInformationController, animated: true)
    }
}
