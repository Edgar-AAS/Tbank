import Foundation
import Domain

public class CardSuccessPresenter {
    private let router: CardSuccessRoutingLogic
    private let digitalCardModel: DigitalCardModel
    
    public init(router: CardSuccessRoutingLogic, digitalCardModel: DigitalCardModel) {
        self.router = router
        self.digitalCardModel = digitalCardModel
    }
}

extension CardSuccessPresenter: ViewToPresenterCardSuccessProtocol {
    public func popToCardController() {
        router.routeToCardView()
    }
    
    public func goToCardInfo() {
        router.routeToCardInfo(digitalCardModel: digitalCardModel)
    }
}
