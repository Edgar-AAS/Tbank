import Foundation
import Domain
import Data
import Presentation
import Infra

func makeProfileController() -> ProfileController {
    //For remote use
    //let cacheManager = CacheManager()
    //let httpClient = makeNetworkGetClient(cacheManager: cacheManager)

    let controller = ProfileController(style: .grouped)
    let localFetchData = makeLocalFetchData(forResource: "personData", withExtension: "json")
    let fetchPersonData = makeRemoteFetchPersonDataFactory(httpGetClient: localFetchData)
    let profilePresenter = ProfilePresenter(
        fetchPersonData: fetchPersonData,
        updatePersonTableView: WeakVarProxy(controller),
        alertView: WeakVarProxy(controller)
    )
    controller.presenter = profilePresenter
    return controller
}

