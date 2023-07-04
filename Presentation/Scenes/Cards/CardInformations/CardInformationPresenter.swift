import Foundation
import Domain

public protocol CardInformationDelegate: AnyObject {
    func digitalCardDidRemoved(isNeedUpdateView: Bool)
}

public class CardInformationPresenter {
    private let updateCardView: UpdateCardView
    private let deleteCard: DeleteDigitalCard
    private let router: CardInformationRoutingLogic
    public let userCardModel: Card
    public let delegateView: CardInformationDelegate
    
    public init(userCardModel: Card,
                deleteCard: DeleteDigitalCard,
                updateCardView: UpdateCardView,
                delegate: CardInformationDelegate,
                router: CardInformationRoutingLogic)
    {
        self.userCardModel = userCardModel
        self.updateCardView = updateCardView
        self.deleteCard = deleteCard
        self.delegateView = delegate
        self.router = router
    }
}

extension CardInformationPresenter: ViewToPresenterCardInformationViewProtocol {
    public func removeDigitalCard(at id: String) {
        deleteCard.deleteDigitalCard(with: id, completion: { [weak self] result in
            guard self != nil else { return }
            switch result {
                case .success:
                    self?.delegateView.digitalCardDidRemoved(isNeedUpdateView: true)
            case .failure:
                print("Erro ao remover cartão")
            }
        })
    }
    
    public func popToHomeController() {
        router.popToHome()
    }

    public func popToCardListController() {
        router.popToCardController()
    }
    
    public func updateCardInformationView() {
        updateCardView.update(userCardModel: userCardModel)
    }
}


