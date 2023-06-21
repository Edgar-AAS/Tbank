import Foundation
import Domain

public protocol CardSuccessRoutingLogic {
    func routeToCardInfo(userCardModel: UserCard)
    func routeToCardView()
}

public protocol ViewToPresenterCardSuccessProtocol: AnyObject {
    func goToCardInfo()
    func popToCardController()
}
