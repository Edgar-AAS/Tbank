import Foundation
import Domain
import Data

public protocol ViewToPresenterHomeProtocol: AnyObject {
    func routeToProfile()
    func routeToCards()
    func fetchData()
    func fechCards()
}

public protocol PresenterToRouterHomeProtocol {
    func goToProfile()
    func goToCardsController()
}
