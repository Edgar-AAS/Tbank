import Foundation
import Domain

public protocol ProfileView {
    func updateProfileView(viewModel: ProfileViewModel)
}

public struct ProfileViewModel: Model {
    public let userImageUrl: String
    public let username: String
    public let isNotifying: Bool
    
    public init(userImageUrl: String, username: String, isNotifying: Bool) {
        self.userImageUrl = userImageUrl
        self.username = username
        self.isNotifying = isNotifying
    }
}
