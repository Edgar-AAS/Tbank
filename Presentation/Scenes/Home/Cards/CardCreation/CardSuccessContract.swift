import Foundation
import Domain

public protocol CardSuccessRoutingLogic {
    func routeToCardInfo(digitalCardModel: DigitalCardModel)
    func routeToCardView()
}

public protocol ViewToPresenterCardSuccessProtocol: AnyObject {
    func goToCardInfo()
    func popToCardController()
}
