import Foundation
import Domain

public class CardSuccessPresenter {
    private let router: CardSuccessRoutingLogic
    private let userCardModel: UserCard
    
    public init(router: CardSuccessRoutingLogic, userCardModel: UserCard) {
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
