import Foundation

public protocol ViewToPresenterPixAreaProtocol {
    func callPixServiceWith(tag: Int)
}

public protocol PixAreaRoutingLogic {
    func routeToServiceWith(tag: Int)
}
