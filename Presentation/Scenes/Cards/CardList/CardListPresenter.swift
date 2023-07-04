import Foundation
import Domain

public class CardListPresenter {
    private let cardsView: UpdateCardListCells
    private let router: CardRoutingLogic
    private let fetchCardList: FetchCardList
    private var userCards: [Card]?
    private var physicalCards: [Card]?
    private var virtualCards: [Card]?
    
    public init(fetchCardList: FetchCardList,
                cardsView: UpdateCardListCells,
                router: CardRoutingLogic)
    {
        self.fetchCardList = fetchCardList
        self.cardsView = cardsView
        self.router = router
    }
}

extension CardListPresenter: ViewToPresenterCardsProtocol {
    public func fetchCardsList() {
        fetchCardList.fetch { [weak self] (result) in
            guard self != nil else { return }
            switch result {
            case .success(let cards):
                self?.physicalCards = cards.filter({ $0.isVirtual == false })
                self?.virtualCards = cards.filter({ $0.isVirtual == true })
                
                if let physicalCards = self?.physicalCards, let virtualCards = self?.virtualCards {
                    let cardList = CardListSource(physicalCards: physicalCards, virtualCards: virtualCards)
                    self?.cardsView.updateCardsList(cardListSource: cardList)
                }
            case .failure: return
            }
        }
    }
    
    public func routeToCardCreationFlow() {
        router.goToCardCreationNavigation()
    }
    
    public func routeToCardInformationViewWith(section: Int, row: Int) {
        if section == .zero {
            guard let virtualCard = virtualCards?[row] else { return }
            router.goToCardInformationScreenWith(userCard: virtualCard)
        } else if section == 1 {
            guard let physicalCard = physicalCards?[row] else { return }
            router.goToCardInformationScreenWith(userCard: physicalCard)
        }
    }
}

