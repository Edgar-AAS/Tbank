import Foundation
import Domain
import Presentation

public let profileFactory: (ProfileInfoModel) -> ProfileController = { userInfo in
    let httpGetClient = makeNetworkGetClient()
    let fetchUserData = makeRemoteFetchUserDataFactory(httpGetClient: httpGetClient)
    let controller = makeProfileController(profileInfoModel: userInfo)
    return controller
}
