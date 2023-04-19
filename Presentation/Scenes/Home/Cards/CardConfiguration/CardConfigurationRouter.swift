import Foundation
import UIKit
import Domain

public class CardConfigurationRouter {
    private weak var viewController: UIViewController?
    private let cardSuccessFactory: (DigitalCardModel) -> CardSuccessViewController
    
    public init(viewController: UIViewController, cardSuccessFactory: @escaping (DigitalCardModel) -> CardSuccessViewController) {
        self.viewController = viewController
        self.cardSuccessFactory = cardSuccessFactory
    }
}

extension CardConfigurationRouter: CardConfigurationRouterLogic {
    public func goToCardSuccessScreen(digitalCardModel: DigitalCardModel) {
        if let controller = viewController {
            DispatchQueue.main.async  { [weak self] in
                guard let self = self else { return }
                controller.navigationController?.pushViewController(self.cardSuccessFactory(digitalCardModel), animated: true)
            }
        }
    }
}
