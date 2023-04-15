import Foundation
import Presentation

func makeCardCreationController() -> CardCreationViewController {
    let cardCreationController = CardCreationViewController()
    let router = CardCreationRouter(cardCreationController: cardCreationController, cardConfigurationFactory: cardConfigurationFactory)
    cardCreationController.goToCardConfiguration = router.goToCardConfiguration
    return cardCreationController
}
