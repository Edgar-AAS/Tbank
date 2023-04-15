import Foundation
import Domain

public class CardInformationPresenter {
    private let digitalCardModel: DigitalCardModel
    private weak var updateCardView: UpdateCardView?
    private let router: CardInformationRoutingLogic
    
    public init(digitalCardModel: DigitalCardModel, updateCardView: UpdateCardView, router: CardInformationRoutingLogic) {
        self.digitalCardModel = digitalCardModel
        self.updateCardView = updateCardView
        self.router = router
    }
}

extension CardInformationPresenter: ViewToPresenterCardInformationViewProtocol {
    func popToCardController() {
        router.popToCardController()
    }
    
    func updateCardInformationView() {
        let model = digitalCardModel
        let cardViewModel = CardModel(name: model.name,
                                      isVirtual: model.isVirtual,
                                      balance: model.balance.currencyWith(symbol: .brazilianReal),
                                      cardFlag: model.cardFlag,
                                      cardTag: model.cardTag,
                                      cardNumber: model.cardNumber.formatString(),
                                      cardExpirationDate: model.cardExpirationDate.toShortDate(),
                                      cardFunction: model.cardFunction,
                                      cvc: model.cvc)
        updateCardView?.update(cardViewModel: cardViewModel)
    }
}


