import Foundation
import Domain
import Validation
import Presentation
import Data
import Infra

func makeHomeViewController() -> HomeController {
    let homeController = HomeController()
    let homeRouter = HomeRouter(viewController: homeController)
//    let cacheManager = CacheManager()
//    let httpGetClient = makeNetworkGetClient(cacheManager: cacheManager)
    let localFetchData = makeLocalFetchUserData()
    let remoteFetchUserData = makeRemoteFetchUserDataFactory(httpGetClient: localFetchData)
    let presenter = HomePresenter(fetchUserData: remoteFetchUserData,
                                  router: homeRouter,
                                  profileView: homeController,
                                  balanceView: homeController,
                                  cardsView: homeController,
                                  serviceView: homeController,
                                  resourcesView: homeController) //retendo ciclo <----
    homeController.presenter = presenter
    return homeController
}
