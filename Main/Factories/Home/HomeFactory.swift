import Foundation
import Presentation

public let homeFactory: () -> HomeController = {
    let httpGetClient = makeNetworkGetClient()
    let fetchUserData = makeRemoteFetchUserDataFactory(httpGetClient: httpGetClient)
    let controller = makeHomeViewController(fetchUserData: fetchUserData, fetchUserCards: makeRemoteFetchCards(httpClient: httpGetClient))
    return controller
}
