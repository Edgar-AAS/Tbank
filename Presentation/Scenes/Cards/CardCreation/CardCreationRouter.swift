import Foundation
import UIKit

public class CardCreationRouter {
    weak var cardCreationController: UIViewController?
    public var cardConfigurationFactory: () -> CardConfigurationViewController
    
    public init(cardCreationController: UIViewController,
                cardConfigurationFactory: @escaping () -> CardConfigurationViewController)
    {
        self.cardCreationController = cardCreationController
        self.cardConfigurationFactory = cardConfigurationFactory
    }
    
    public func goToCardConfiguration() {
        cardCreationController?.navigationController?.pushViewController(cardConfigurationFactory(), animated: true)
    }
}
