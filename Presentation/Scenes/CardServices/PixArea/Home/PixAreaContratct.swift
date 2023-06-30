import Foundation
import Domain

public protocol ViewToPresenterPixAreaProtocol {
    func callPixServiceWith(tag: Int)
    func getServicesCell() -> [Service]
    func getNumberOfCells() -> Int
}

public protocol PixAreaRoutingLogic {
    func routeToServiceWith(tag: Int)
}
