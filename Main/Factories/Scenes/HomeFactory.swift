import Foundation
import Presentation

public let homeFactory: () -> HomeController = {
//    let httpGetClient = makeNetworkGetClient() <- REMOTE
    let localFetchUserData = makeLocalFetchData(forResource: "userData", withExtension: "json")
    let fetchUserData = makeRemoteFetchUserDataFactory(httpGetClient: localFetchUserData)
    let controller = makeHomeViewController(fetchUserData: fetchUserData)
    return controller
}
