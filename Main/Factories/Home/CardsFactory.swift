import Foundation
import Presentation
import Infra

public let carsListFactory: () -> CardsViewController = {
    let httpGetClient = makeNetworkGetClient(cacheManager: nil)
    let fetchCards = makeRemoteFetchCards(httpClient: httpGetClient)
    let controller = makeCardsViewController(fethUserCards: fetchCards)
    return controller
}
