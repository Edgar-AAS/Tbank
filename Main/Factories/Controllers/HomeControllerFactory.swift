import Foundation
import Domain
import Validation
import Presentation
import Data
import Infra

func makeHomeViewController() -> HomeController {
    //For remote use
    //let cacheManager = CacheManager()
    //let httpGetClient = makeNetworkGetClient(cacheManager: cacheManager)
    
    let homeController = HomeController()
    let homeRouter = HomeRouter(viewController: homeController, destinationController: makeProfileController())
    let localFetchData = makeLocalFetchData(forResource: "userData", withExtension: "json")
    let remoteFetchUserData = makeRemoteFetchUserDataFactory(httpGetClient: localFetchData)
    let presenter = HomePresenter(fetchUserData: remoteFetchUserData,
                                  router: homeRouter,
                                  profileView: WeakVarProxy(homeController),
                                  balanceView: WeakVarProxy(homeController),
                                  cardsView: WeakVarProxy(homeController),
                                  serviceView: WeakVarProxy(homeController),
                                  resourcesView: WeakVarProxy(homeController),
                                  alertView: WeakVarProxy(homeController))
    homeController.presenter = presenter
    return homeController
}
