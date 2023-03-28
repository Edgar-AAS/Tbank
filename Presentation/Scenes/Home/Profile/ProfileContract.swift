import Foundation

public protocol ProfileHeaderDelegateProtocol: AnyObject {
    func userPhotoImageDidTapped()
}

public protocol ViewToPresenterProfileProtocol {
    func fetchPersonalData()
}
