import Foundation
import Presentation
import Infra

public let cardListFactory: () -> CardsViewController = {
    let httpGetClient = makeNetworkGetClient()
    let fetchCards = makeRemoteFetchCards(httpClient: httpGetClient)
    let controller = makeCardsViewController(fethUserCards: fetchCards)
    return controller
}
