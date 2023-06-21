import Foundation

public protocol ProfileHeaderDelegateProtocol: AnyObject {
    func userPhotoImageDidTapped()
}

public protocol ViewToProfilePresenterProtocol {
    func fetchUser()
}
