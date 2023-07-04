import Foundation
import Domain

public class ProfilePresenter {
    public let profileInfoModel: ProfileInfoModel
    public weak var updateProfileListCells: UpdateProfileListCellsProtocol?
    
    public init(profileInfoModel: ProfileInfoModel, updateProfileListCells: UpdateProfileListCellsProtocol) {
        self.profileInfoModel = profileInfoModel
        self.updateProfileListCells = updateProfileListCells
    }
}

extension ProfilePresenter: ViewToProfilePresenterProtocol {
    public func fetchPersonalUserInfo() {
        let profileInfoViewModel = ProfileInfoViewModel(username: profileInfoModel.userName,
                                                    bankBranch: profileInfoModel.bankBranch,
                                                    bankAccountNumber: profileInfoModel.bankAccountNumber.formatBankAccountNumber(),
                                                    bankNumber: profileInfoModel.bankNumber,
                                                    corporateName: profileInfoModel.corporateName)
            
        let personInfos = ["Meu banco", "Meu número", "Meu email", "Dados pessoais", "Tarifas e taxas", "Meus endereços"]
        let profileDataViewModels = personInfos.map( { PersonalDataViewModel(infoName: $0, infoValue: "123") })
                
        updateProfileListCells?.updateProfileCellsWith(profileListDataSource: profileDataViewModels,
                                                       personalHeaderDataSource: profileInfoViewModel)
    }
}
