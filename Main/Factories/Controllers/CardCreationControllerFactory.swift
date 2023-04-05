import Foundation
import Domain
import Data
import Presentation
import Infra

func makeCardCreationController() -> CardCreationViewController {
    let viewController = CardCreationViewController()
    let cardConfigurationController = CardConfigurationViewController()
    let router = CardCreationRouter(viewController: viewController, cardConfigurationViewController: cardConfigurationController)
    let presenter = CardCreationPresenter(router: router)
    viewController.presenter = presenter
    return viewController
}
