import Foundation
import Domain

public protocol ViewToPresenterPixAreaProtocol {
    func callPixServiceWith(tag: Int)
    func fetchPixServices()
}

public protocol PixAreaRoutingLogic {
    func routeToServiceWith(tag: Int)
}

public protocol UpdatePixAreaListCellsProtocol: AnyObject {
    func updatePixAreaCellsWith(dataSource: [PixAreaCellsType])
}
