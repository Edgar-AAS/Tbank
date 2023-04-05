import Foundation
import Domain
import Presentation
import Infra
import Data
import UIKit

func makeCardsViewController() -> CardsViewController {
    let viewController = CardsViewController()
    let destinationController = makeCardCreationController() //factory
    let router = CardsRouter(viewController: viewController, destinationController: destinationController)
    let localRequest = makeLocalFetchData(forResource: "userData", withExtension: "json")
    let remoteFetchUserData = makeRemoteFetchUserDataFactory(httpGetClient: localRequest)
    let presenter = CardsPresenter(remoteFetchUserData: remoteFetchUserData, cardsView: viewController, router: router)
    viewController.presenter = presenter
    return viewController
}
