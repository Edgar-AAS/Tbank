import Foundation
import Presentation

public let profileFactory: () -> ProfileController = {
    let httpGetClient = makeNetworkGetClient(cacheManager: nil)
    let fetchUserData = makeRemoteFetchUserDataFactory(httpGetClient: httpGetClient)
    let controller = makeProfileController(fetchUserData: fetchUserData)
    return controller
}
