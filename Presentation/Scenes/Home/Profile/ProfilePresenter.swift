import Foundation
import Domain

public class ProfilePresenter {
    public let fetchPersonData: FetchPersonDataResources
    public let updateProfileView: UpdateProfileView
    public let alertView: AlertView
    
    public init(fetchPersonData: FetchPersonDataResources, updatePersonTableView: UpdateProfileView, alertView: AlertView) {
        self.fetchPersonData = fetchPersonData
        self.updateProfileView = updatePersonTableView
        self.alertView = alertView
    }
}

extension ProfilePresenter: ViewToPresenterProfileProtocol {
    public func fetchPersonalData() {
        fetchPersonData.fetch { [weak self] (result) in
            guard self != nil else { return }
            switch result {
            case .success(let personDataModel):
                self?.updateProfileView.updateWith(viewModel: personDataModel)
            case .failure:
                self?.alertView.showMessage(viewModel: AlertViewModel(title: "Error ao carregar dados.", message: "tente novamente em instantes"))
            }
        }
    }
}
