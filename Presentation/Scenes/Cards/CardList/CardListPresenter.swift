import Foundation
import Domain

public class CardListPresenter {
    private let cardsView: CardsView
    private let router: CardRoutingLogic
    private let remoteFetchCards: FetchUserCards
    private var userCards: [Card]?
    private var physicalCards: [Card]?
    private var virtualCards: [Card]?
    
    public init(remoteFetchCards: FetchUserCards, cardsView: CardsView, router: CardRoutingLogic) { 
        self.remoteFetchCards = remoteFetchCards
        self.cardsView = cardsView
        self.router = router
    }
}

extension CardListPresenter: ViewToPresenterCardsProtocol {
    public func fetchCards() {
        remoteFetchCards.fetch { [weak self] (result) in
            guard self != nil else { return }
            switch result {
            case .success(let userCards):
                self?.physicalCards = userCards.filter({ $0.isVirtual == false })
                self?.virtualCards = userCards.filter({ $0.isVirtual == true })
                self?.cardsView.updateCardsView(cardsModel: userCards)
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

