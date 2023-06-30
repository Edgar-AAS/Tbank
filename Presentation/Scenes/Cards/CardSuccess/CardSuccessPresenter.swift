import Foundation
import Domain

public class CardSuccessPresenter {
    private let router: CardSuccessRoutingLogic
    private let userCardModel: Card
    
    public init(router: CardSuccessRoutingLogic, userCardModel: Card) {
        self.router = router
        self.userCardModel = userCardModel
    }
}

extension CardSuccessPresenter: ViewToPresenterCardSuccessProtocol {
    public func popToCardController() {
        router.routeToCardView()
    }
    
    public func goToCardInfo() {
        router.routeToCardInfo(userCardModel: userCardModel)
    }
}
