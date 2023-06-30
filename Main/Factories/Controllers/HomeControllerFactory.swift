import Foundation
import Domain
import Validation
import Presentation
import Data
import Infra

func makeHomeViewController(fetchUserData: FetchUserDataResources) -> HomeController {
    let homeController = HomeController()
    let homeRouter = HomeRouter(viewController: homeController,
                                profileControllerFactory: profileFactory,
                                cardsControllerFactory: cardListFactory,
                                cardInformationFactory: makeCardInformationFactory,
                                pixAreaControllerFactory: makePixAreaControllerFactory)
    let presenter = HomePresenter(dataSource: fetchUserData,
                                  router: homeRouter,
                                  updateHomeListCell: WeakVarProxy(homeController),
                                  alertView: WeakVarProxy(homeController))
    homeController.presenter = presenter
    return homeController
}
