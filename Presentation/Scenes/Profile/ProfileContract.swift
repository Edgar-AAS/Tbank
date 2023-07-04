import Foundation

public protocol ProfileHeaderDelegateProtocol: AnyObject {
    func userPhotoImageDidTapped()
}

public protocol UpdateProfileListCellsProtocol: AnyObject {
    func updateProfileCellsWith(profileListDataSource: [PersonalDataViewModel],
                                personalHeaderDataSource: ProfileInfoViewModel)
}

public protocol ViewToProfilePresenterProtocol {
    func fetchPersonalUserInfo()
}
