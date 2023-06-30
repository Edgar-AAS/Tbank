import Foundation
import Domain


public protocol UpdateHomeListCellsProtocol: AnyObject {
    func updateHomeCellsWith(homeList: [HomeListCellType])
}

public final class HomePresenter {
    private let router: PresenterToRouterHomeProtocol?
    private let dataSource: FetchUserDataResources
    private let updateHomeListCell: UpdateHomeListCellsProtocol
    private let alertView: AlertView
    
    public init(dataSource: FetchUserDataResources,
                router: PresenterToRouterHomeProtocol?,
                updateHomeListCell: UpdateHomeListCellsProtocol,
                alertView: AlertView
    ) {
        self.dataSource = dataSource
        self.updateHomeListCell = updateHomeListCell
        self.alertView = alertView
        self.router = router
    }
}

extension HomePresenter: ViewToPresenterHomeProtocol {
    public func routeToServiceWith(tag: Int) {
        router?.goToCardServiceWith(tag: tag)
    }
    
    public func routeToCardInformationScreen(with cardModel: Card) {
        router?.goToInformationControllerWith(selectedCard: cardModel)
    }
    
    public func fetchUserData() {
        dataSource.fetch { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let model):
                let profileViewModel = PersonHeaderViewModel(username: model.username, isNotifying: model.isNotifying)
                let balanceViewModel = BalanceViewModel(totalBalance: model.totalBalance.currencyWith(symbol: .brazilianReal),
                                                        balanceIsHidden: model.balanceIsHidden)
                
                let cardsViewModel = model.cards.map( { CardViewModel(isVirtual: $0.isVirtual,
                                                                      balance: $0.balance.currencyWith(symbol: .brazilianReal),
                                                                      cardFlag: $0.cardFlag,
                                                                      cardTag: $0.cardTag,
                                                                      cardBrandImageURL: $0.cardBrandImageURL,
                                                                      cardNumber: $0.cardNumber.toSafeCardNumber(),
                                                                      cardExpirationDate: $0.cardExpirationDate.toShortDate(),
                                                                      cardFunction: $0.cardFunction,
                                                                      cvc: $0.cvc,
                                                                      id: $0.id,
                                                                      name: $0.name)})
                
                let serviceViewModel = model.services.map( { ServiceViewModel(iconURL: $0.iconURL, serviceName: $0.serviceName, serviceTag: $0.serviceTag ) })
                let resourcesViewModel = model.resources.map({ ResourceViewModel(resourceID: $0.resourceID, applogoURL: $0.applogoURL, resourceDescription: $0.resourceDescription) })
                
                let homeListCellType: [HomeListCellType] = [
                    .userHeaderCell(profileViewModel),
                    .balanceCell(balanceViewModel),
                    .cardsCell(cardsViewModel),
                    .servicesCell(serviceViewModel),
                    .resourcesCell(resourcesViewModel)
                ]
                self?.updateHomeListCell.updateHomeCellsWith(homeList: homeListCellType)
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
