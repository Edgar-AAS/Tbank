import Foundation

public class CardCreationPresenter {    
    private let router: CardCreationRoutingLogic
    
    public init(router: CardCreationRoutingLogic) {
        self.router = router
    }
}

extension CardCreationPresenter: ViewToPresenterCardCreationProtocol {
    public func routeToCardConfiguration() {
        router.goToCardConfiguration()
    }
}
