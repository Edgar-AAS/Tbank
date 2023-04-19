import Foundation
import Domain

public class CardListPresenter {
    private let cardsView: CardsView
    private let router: CardRoutingLogic
    private let remoteFetchCards: FetchUserCards
    private var userCards: UserCards?
    private var physicalCards: [UserCard]?
    private var virtualCards: [UserCard]?
    
    public init(remoteFetchCards: FetchUserCards, cardsView: CardsView, router: CardRoutingLogic) {
        self.remoteFetchCards = remoteFetchCards
        self.cardsView = cardsView
        self.router = router
    }
}

//View to Presenter
extension CardListPresenter: ViewToPresenterCardsProtocol {
    public func fetchCards() {
        remoteFetchCards.fetch { [weak self] (result) in
            guard self != nil else { return }
            switch result {
            case .success(let userCards):
                self?.userCards = userCards
                
                self?.physicalCards = userCards.filter({ $0 .isVirtual == false })
                self?.virtualCards =  userCards.filter({ $0 .isVirtual == true })
                
                let userCardsMapped = userCards.map { CardModel(id: $0.id,
                                                                name: $0.name,
                                                                isVirtual: $0.isVirtual,
                                                                balance: $0.balance.currencyWith(symbol: .brazilianReal),
                                                                cardFlag: $0.cardFlag,
                                                                cardTag: $0.cardTag,
                                                                cardBrandImageUrl: $0.cardBrandImageURL,
                                                                cardNumber: $0.cardNumber.toSafeCardNumber(),
                                                                cardExpirationDate: $0.cardExpirationDate.toShortDate(),
                                                                cardFunction: $0.cardFunction,
                                                                cvc: $0.cvc) }
                self?.cardsView.updateCardsView(viewModel: CardsViewViewModel(cards: userCardsMapped))
            case .failure: return
            }
        }
    }
    
    public func routeToCardCreationFlow() {
        router.goToCardCreationNavigation()
    }
    
    public func routeToCardInformationViewWith(indexPath: IndexPath) {
        if indexPath.section == 0 {
            guard let virtualCard = virtualCards?[indexPath.row] else { return }
            router.goToCardInformationScreenWith(userCard: virtualCard)
        } else if indexPath.section == 1 {
            guard let physicalCard = physicalCards?[indexPath.row] else { return }
            router.goToCardInformationScreenWith(userCard: physicalCard)
        }
    }
}

