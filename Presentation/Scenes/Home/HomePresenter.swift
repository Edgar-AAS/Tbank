import Foundation
import Domain

public final class HomePresenter {
    private let router: PresenterToRouterHomeProtocol?
    private let fetchUserData: FetchUserDataResources //<- use case
    private let profileView: ProfileView  //<- controller
    private let balanceView: BalanceView //<- controller
    private let cardsView: CardsView //<- controller
    private let serviceView: ServicesView //<- controller
    private let resourcesView: ResourcesView //<- controller
        
    private var userData: UserModelElement?
    
    public init(fetchUserData: FetchUserDataResources,
                router: PresenterToRouterHomeProtocol?,
                profileView: ProfileView,
                balanceView: BalanceView,
                cardsView: CardsView,
                serviceView: ServicesView,
                resourcesView: ResourcesView
    ) {
        self.fetchUserData = fetchUserData
        self.profileView = profileView
        self.balanceView = balanceView
        self.cardsView = cardsView
        self.serviceView = serviceView
        self.resourcesView = resourcesView
        self.router = router
    }
}

extension HomePresenter: ViewToPresenterHomeProtocol {
    public func fetchData() {
        fetchUserData.fetch { result in
            switch result {
            case .success(let model):
                if let userModel = model.first {
                    self.userData = userModel
                    self.profileView.updateProfileView(viewModel: ProfileViewModel(userImageUrl: userModel.userImageURL, username: userModel.username, isNotifying: userModel.isNotifying))
                    self.balanceView.updateBalanceView(viewModel: BalanceViewModel(totalBalance: userModel.totalBalance.currencyWith(symbol: .brazilianReal), balanceIsHidden: userModel.balanceIsHidden))
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
                    self.cardsView.updateCardsView(viewModel: CardsViewViewModel(cards: cards))
                    self.serviceView.updateServicesView(services: userModel.mainServices)
                    self.resourcesView.updateResourcesView(resources: userModel.resources)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func routeToProfile() {
        router?.goToProfile() //passa os dados para o router
    }
}
