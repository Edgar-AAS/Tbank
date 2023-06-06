import Foundation
import Domain

public final class HomePresenter {
    private let router: PresenterToRouterHomeProtocol?
    private let fetchUserData: FetchUserDataResources
    private let fetchUserCards: FetchUserCards
    private let profileView: ProfileView
    private let balanceView: BalanceView
    private let cardsView: CardsView
    private let serviceView: ServicesView
    private let resourcesView: ResourcesView
    private let alertView: AlertView

    public init(fetchUserData: FetchUserDataResources,
                fetchUserCards: FetchUserCards,
                router: PresenterToRouterHomeProtocol?,
                profileView: ProfileView,
                balanceView: BalanceView,
                cardsView: CardsView,
                serviceView: ServicesView,
                resourcesView: ResourcesView,
                alertView: AlertView
    ) {
        self.fetchUserData = fetchUserData
        self.fetchUserCards = fetchUserCards
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
    public func routeToCardInformationScreen(with cardModel: UserCard) {
        router?.goToInformationControllerWith(selectedCard: cardModel)
    }
    
    public func fechCards() {
        fetchUserCards.fetch { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let cardsModel):
                self?.cardsView.updateCardsView(cardsModel: cardsModel)
            case .failure(let error):
                switch error {
                case .unexpected:
                    self?.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em instantes."))
                default: return
                }
            }
        }
    }
    
    public func fetchData() {
        fetchUserData.fetch { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let model):
                if let userModel = model.first {
                    self?.profileView.updateProfileView(viewModel: ProfileViewModel(userImageUrl: userModel.userImageURL, username: userModel.username, isNotifying: userModel.isNotifying))
                    self?.balanceView.updateBalanceView(viewModel: BalanceViewModel(totalBalance: userModel.totalBalance.currencyWith(symbol: .brazilianReal), balanceIsHidden: userModel.balanceIsHidden))
                    self?.serviceView.updateServicesView(services: userModel.services)
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
    
    public func routeToCards() {
        router?.goToCardsController()
    }
}
