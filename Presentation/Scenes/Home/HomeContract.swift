import Foundation
import Domain
import Data

public protocol ViewToPresenterHomeProtocol: AnyObject {
    func routeToProfile()
    func routeToCards()
    func fetchData()
}

public protocol PresenterToRouterHomeProtocol {
    func goToProfile()
    func goToCardsController()
}
