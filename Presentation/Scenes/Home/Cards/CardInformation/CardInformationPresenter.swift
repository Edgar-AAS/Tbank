import Foundation
import Domain

public protocol CardInformationDelegate: AnyObject {
    func digitalCardDidRemoved(isNeedUpdateView: Bool)
}

public class CardInformationPresenter {
    private let updateCardView: UpdateCardView
    private let deleteCard: DeleteDigitalCard
    private let router: CardInformationRoutingLogic
    public let digitalCardModel: DigitalCardModel
    public let delegate: CardInformationDelegate

    public init(digitalCardModel: DigitalCardModel,
                deleteCard: DeleteDigitalCard,
                updateCardView: UpdateCardView,
                delegate: CardInformationDelegate,
                router: CardInformationRoutingLogic
    ) {
        self.digitalCardModel = digitalCardModel
        self.updateCardView = updateCardView
        self.deleteCard = deleteCard
        self.delegate = delegate
        self.router = router
    }
}

extension CardInformationPresenter: ViewToPresenterCardInformationViewProtocol {
    public func removeCard(at id: String) {
        if let url = URL(string: "https://63e255d8109336b6cb054df8.mockapi.io/api/v1/cards/" + id) {
            deleteCard.deleteCardWith(url: url, completion: { [weak self] result in
                switch result {
                    case .success: print("Cartao digital removido com sucesso.")
                        self?.delegate.digitalCardDidRemoved(isNeedUpdateView: true)
                    case .failure: print("Falha ao remover cartão. tente novamente em instantes.")
                }
            })
        }
    }
    
    public func popToCardController() {
        router.popToCardController()
        }
        
    public func updateCardInformationView() {
        let model = digitalCardModel
        let cardViewModel = CardModel(id: model.id,
                                      name: model.name,
                                      isVirtual: model.isVirtual,
                                      balance: model.balance.currencyWith(symbol: .brazilianReal),
                                      cardFlag: model.cardFlag,
                                      cardTag: model.cardTag,
                                      cardNumber: model.cardNumber.formatString(),
                                      cardExpirationDate: model.cardExpirationDate.toShortDate(),
                                      cardFunction: model.cardFunction,
                                      cvc: model.cvc)
        updateCardView.update(cardViewModel: cardViewModel)
    }
}


