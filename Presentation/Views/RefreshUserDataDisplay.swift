import Foundation

public protocol RefreshUserDataDisplay {
    func update(viewModel: UserDataViewModel)
}

public struct UserDataViewModel {
    public let username: String
    public let totalBalance: String
    
    public init(username: String, totalBalance: String) {
        self.username = username
        self.totalBalance = totalBalance
    }
}
