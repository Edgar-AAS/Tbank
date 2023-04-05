import Foundation
import Domain

public class CardsPresenter {
    private let remoteFetchUserData: FetchUserDataResources
    private let cardsView: CardsView
    private let router: CardRoutingLogic

    public init(remoteFetchUserData: FetchUserDataResources, cardsView: CardsView, router: CardRoutingLogic) {
        self.remoteFetchUserData = remoteFetchUserData
        self.cardsView = cardsView
        self.router = router
    }
}

//View to Presenter
extension CardsPresenter: ViewToPresenterCardsProtocol {
    public func fetchCards() {
        remoteFetchUserData.fetch { [weak self] (result) in
            switch result {
            case .success(let userModel):
                if let userModelCards = userModel.first?.cards {
                    let cardsModel = userModelCards.map { CardModel(isVirtual: $0.isVirtual,
                                                                   balance: $0.balance.currencyWith(symbol: .brazilianReal),
                                                                   cardFlag: $0.cardFlag,
                                                                   cardTag: $0.cardTag,
                                                                   cardBrandImageUrl: $0.cardBrandImageURL,
                                                                   cardNumber: $0.cardNumber.toSafeCardNumber(),
                                                                   cardExpirationDate: $0.cardExpirationDate.toShortDate(),
                                                                   cardFunction: $0.cardFunction,
                                                                   cvc: $0.cvc) }
                    self?.cardsView.updateCardsView(viewModel: CardsViewViewModel(cards: cardsModel))
                }
            case .failure:
                return
            }
        }
    }
    
    public func routeToCardCreationFlow() {
        router.goToCardCreationNavigation()
    }
}
