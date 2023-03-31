import Foundation
import Domain

public final class HomePresenter {
    private let router: PresenterToRouterHomeProtocol?
    private let fetchUserData: FetchUserDataResources
    private let profileView: ProfileView
    private let balanceView: BalanceView
    private let cardsView: CardsView
    private let serviceView: ServicesView
    private let resourcesView: ResourcesView
    private let alertView: AlertView
    
    private var userData: UserModelElement?
    
    public init(fetchUserData: FetchUserDataResources,
                router: PresenterToRouterHomeProtocol?,
                profileView: ProfileView,
                balanceView: BalanceView,
                cardsView: CardsView,
                serviceView: ServicesView,
                resourcesView: ResourcesView,
                alertView: AlertView
    ) {
        self.fetchUserData = fetchUserData
        self.profileView = profileView
        self.balanceView = balanceView
        self.cardsView = cardsView
        self.serviceView = serviceView
        self.resourcesView = resourcesView
        self.alertView = alertView
        self.router = router
    }
}

extension HomePresenter: ViewToPresenterHomeProtocol {
    public func fetchData() {
        fetchUserData.fetch { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let model):
                if let userModel = model.first {
                    self?.userData = userModel
                    self?.profileView.updateProfileView(viewModel: ProfileViewModel(userImageUrl: userModel.userImageURL, username: userModel.username, isNotifying: userModel.isNotifying))
                    self?.balanceView.updateBalanceView(viewModel: BalanceViewModel(totalBalance: userModel.totalBalance.currencyWith(symbol: .brazilianReal), balanceIsHidden: userModel.balanceIsHidden))
                    let userCardModelArray = userModel.cards
                    let cards = userCardModelArray.map { CardModel(isVirtual: $0.isVirtual,
                                                                   balance: $0.balance.currencyWith(symbol: .brazilianReal),
                                                                   cardFlag: $0.cardFlag,
                                                                   cardTag: $0.cardTag,
                                                                   cardBrandImageUrl: $0.cardBrandImageURL,
                                                                   cardNumber: $0.cardNumber.toSafeCardNumber(),
                                                                   cardExpirationDate: $0.cardExpirationDate.toShortDate(),
                                                                   cardFunction: $0.cardFunction,
                                                                   cvc: $0.cvc) }
                    self?.cardsView.updateCardsView(viewModel: CardsViewViewModel(cards: cards))
                    self?.serviceView.updateServicesView(services: userModel.mainServices)
                    self?.resourcesView.updateResourcesView(resources: userModel.resources)
                }
            case .failure(let error):
                switch error {
                case .unexpected:
                    self?.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em instantes."))
                default: return
                }
            }
        }
    }
    
    public func routeToProfile() {
        router?.goToProfile()
    }
}
