import Foundation
import Domain
import Data

public protocol ViewToPresenterHomeProtocol: AnyObject {
    func routeToProfile()
    func routeToCards()
    func routeToCardInformationScreen(with cardModel: UserCard)
    func fetchData()
    func fechCards()
}

public protocol PresenterToRouterHomeProtocol {
    func goToProfile()
    func goToCardsController()
    func goToInformationControllerWith(selectedCard: UserCard)
}
