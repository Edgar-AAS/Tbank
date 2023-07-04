import Foundation
import Presentation
import Infra

public let cardListFactory: () -> CardsViewController = {
    let httpGetClient = makeNetworkGetClient()
    let fetchCardList = makeRemoteFetchCard(httpClient: httpGetClient)
    let controller = makeCardsViewController(fetchCardList: fetchCardList)
    return controller
}
