import Foundation

public final class PixAreaServicePresenter {
    private let router: PixAreaRoutingLogic
    
    public init (router: PixAreaRoutingLogic) {
        self.router = router
    }
}

extension PixAreaServicePresenter: ViewToPresenterPixAreaProtocol {
    public func callPixServiceWith(tag: Int) {
        router.routeToServiceWith(tag: tag)
    }
}
