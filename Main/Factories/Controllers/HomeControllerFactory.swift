import Foundation
import Domain
import Validation
import Presentation
import Data
import Infra

func makeHomeViewController() -> HomeController {
    let homeController = HomeController()
    let homeRouter = HomeRouter(viewController: homeController)
    let cacheManager = CacheManager()
    let httpGetClient = RemoteGetService(cacheManager: cacheManager)
    let remoteFetchUserData = makeRemoteFetchUserDataFactory(httpGetClient: httpGetClient)
    let presenter = HomePresenter(fetchUserData: remoteFetchUserData,
                                  router: homeRouter,
                                  updateUserDataDisplay: homeController)
    homeController.presenter = presenter
    return homeController
}
