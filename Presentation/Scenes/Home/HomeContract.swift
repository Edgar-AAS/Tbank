import Foundation
import Domain
import Data

public protocol ViewToPresenterHomeProtocol: AnyObject {
    func routeToProfile()
    func routeToCards()
    func routeToCardInformationScreen(with cardModel: Card)
    func routeToServiceWith(tag: Int)
    func fetchUserData()
}

public protocol PresenterToRouterHomeProtocol {
    func goToProfile()
    func goToCardsController()
    func goToInformationControllerWith(selectedCard: Card)
    func goToCardServiceWith(tag: Int)
}
