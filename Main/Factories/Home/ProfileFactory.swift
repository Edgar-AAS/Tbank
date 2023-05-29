import Foundation
import Presentation

public let profileFactory: () -> ProfileController = {
    let httpGetClient = makeNetworkGetClient()
    let fetchUserData = makeRemoteFetchUserDataFactory(httpGetClient: httpGetClient)
    let controller = makeProfileController(fetchUserData: fetchUserData)
    return controller
}
