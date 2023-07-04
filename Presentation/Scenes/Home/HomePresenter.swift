import Foundation
import Domain

public final class HomePresenter {
    private let router: PresenterToRouterHomeProtocol?
    private let homeDataSource: FetchUserDataResources
    private let updateHomeListCell: UpdateHomeListCellsProtocol
    private let alertView: AlertView
    
    private var personalUserInfo: ProfileInfoModel?
    
    public init(dataSource: FetchUserDataResources,
                router: PresenterToRouterHomeProtocol?,
                updateHomeListCell: UpdateHomeListCellsProtocol,
                alertView: AlertView)
    {
        self.homeDataSource = dataSource
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
        homeDataSource.fetch { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let userData):
                guard let model = userData.first else { return }
                let profileViewModel = PersonHeaderViewModel(username: model.username, isNotifying: model.isNotifying)
                let balanceViewModel = BalanceViewModel(totalBalance: model.totalBalance.currencyWith(symbol: .brazilianReal),
                                                        balanceIsHidden: model.balanceIsHidden)
                
                let serviceViewModels = model.services.map( { ServiceViewModel(iconURL: $0.iconURL,
                                                                               serviceName: $0.serviceName,
                                                                               serviceTag: $0.serviceTag ) })
                
                let resourcesViewModels = model.resources.map({ ResourceViewModel(resourceID: $0.resourceID,
                                                                                  applogoURL: $0.applogoURL,
                                                                                  resourceDescription: $0.resourceDescription) })
                
                self?.personalUserInfo = ProfileInfoModel(userName: model.username,
                                                          bankBranch: model.bankBranch,
                                                          bankAccountNumber: model.bankAccountNumber,
                                                          bankNumber: model.bankNumber,
                                                          corporateName: model.corporateName)
                
                let homeListDataSource: [HomeListCellType] = [
                    .userHeaderCell(profileViewModel),
                    .balanceCell(balanceViewModel),
                    .cardsCell(model.cards),
                    .servicesCell(serviceViewModels),
                    .resourcesCell(resourcesViewModels)
                ]
                
                self?.updateHomeListCell.updateHomeCellsWith(homeList: homeListDataSource)
            case .failure(let error):
                switch error {
                case .unexpected:
                    self?.alertView.showMessage(viewModel: AlertViewModel(title: "Erro",
                                                                          message: "Algo inesperado aconteceu, tente novamente em instantes."))
                default: return
                }
            }
        }
    }
    
    public func routeToProfile() {
        guard let userInfo = personalUserInfo else { return }
        router?.goToProfileWith(personalUserInfo: userInfo)
    }
    
    public func routeToCardList() {
        router?.goToCardsController()
    }
}
