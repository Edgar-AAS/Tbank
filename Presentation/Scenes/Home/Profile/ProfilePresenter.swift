import Foundation
import Domain

public class ProfilePresenter {
    public let fetchUserData: FetchUserDataResources
    public let updateProfileView: UpdateProfileView
    public let alertView: AlertView
    
    public init(fetchUserData: FetchUserDataResources, updatePersonTableView: UpdateProfileView, alertView: AlertView) {
        self.fetchUserData = fetchUserData
        self.updateProfileView = updatePersonTableView
        self.alertView = alertView
    }
}

extension ProfilePresenter: ViewToProfilePresenterProtocol {
    public func fetchUser() {
        fetchUserData.fetch { [weak self] (result) in
            guard self != nil else { return }
            switch result {
            case .success(let userData):
                if let data = userData.first {
                    let userDataViewModel = UserDataViewModel(username: data.username,
                                                              bankBranch: data.bankBranch,
                                                              bankAccountNumber: data.bankAccountNumber.formatBankAccountNumber(),
                                                              bankNumber: data.bankNumber,
                                                              corporateName: data.corporateName)
                    self?.updateProfileView.updateWith(viewModel: userDataViewModel)
                }
            case .failure:
                self?.alertView.showMessage(viewModel: AlertViewModel(title: "Error ao carregar dados.", message: "tente novamente em instantes"))
            }
        }
    }
}
