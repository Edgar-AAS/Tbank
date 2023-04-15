import Foundation
import Domain
import Validation
import Presentation
import Data
import Infra

func makeHomeViewController(fetchUserData: FetchUserDataResources, fetchUserCards: FetchUserCards) -> HomeController {
    let homeController = HomeController()
    let homeRouter = HomeRouter(viewController: homeController, profileControllerFactory: profileFactory, cardsControllerFactory: carsListFactory)
    let presenter = HomePresenter(fetchUserData: fetchUserData,
                                  fetchUserCards: fetchUserCards,
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
