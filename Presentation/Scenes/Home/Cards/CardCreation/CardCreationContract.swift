import Foundation

public protocol CardCreationRoutingLogic {
    func goToCardConfiguration()
}

public protocol ViewToPresenterCardCreationProtocol: AnyObject {
    func routeToCardConfiguration()
}
