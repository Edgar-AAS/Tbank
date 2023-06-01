import Foundation
import Domain
import Presentation
import Infra
import Data

func makeCardsViewController(fethUserCards: FetchUserCards) -> CardsViewController {
    let viewController = CardsViewController()
    let router = CardsRouter(viewController: viewController, cardCreationFactory: makeCardCreationController, cardInformationFactory: makeCardInformationFactory)
    let presenter = CardListPresenter(remoteFetchCards: fethUserCards, cardsView: viewController, router: router)
    viewController.presenter = presenter
    return viewController
}
