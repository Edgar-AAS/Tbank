import Foundation
import Presentation

public let homeFactory: () -> HomeController = {
    let httpGetClient = makeNetworkGetClient(cacheManager: nil)
    let fetchUserData = makeRemoteFetchUserDataFactory(httpGetClient: httpGetClient)
    let controller = makeHomeViewController(fetchUserData: fetchUserData, fetchUserCards: makeRemoteFetchCards(httpClient: httpGetClient))
    return controller
}
