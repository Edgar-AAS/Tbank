import Foundation
import Domain

public final class HomePresenter {
    private let router: PresenterToRouterHomeProtocol?
    private let fetchUserData: FetchUserDataResources
    private let updateUserDataDisplay: RefreshUserDataDisplay //<- ou usa o proxy ou weak var
    
    public init(fetchUserData: FetchUserDataResources,
                router: PresenterToRouterHomeProtocol?,
                updateUserDataDisplay: RefreshUserDataDisplay //<- retendo ciclo
    ) {
        self.fetchUserData = fetchUserData
        self.router = router
        self.updateUserDataDisplay = updateUserDataDisplay
    }
}

extension HomePresenter: ViewToPresenterHomeProtocol {
    public func fetchData() {
        fetchUserData.fetch { [weak self] result in
            switch result {
            case .success(let model):
//                let userDataViewModel = UserDataViewModel(username: model.username, totalBalance: model.totalBalance)
                print(model)
//                self?.updateUserDataDisplay.update(viewModel: userDataViewModel) // fora da main
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func routeToProfile() {
        router?.goToProfile()
    }
}
