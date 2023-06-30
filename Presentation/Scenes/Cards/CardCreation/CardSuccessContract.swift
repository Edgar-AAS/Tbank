import Foundation
import Domain

public protocol CardSuccessRoutingLogic {
    func routeToCardInfo(userCardModel: Card)
    func routeToCardView()
}

public protocol ViewToPresenterCardSuccessProtocol: AnyObject {
    func goToCardInfo()
    func popToCardController()
}
