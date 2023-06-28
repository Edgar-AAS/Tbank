import Foundation
import Domain

public protocol UpdateProfileView {
    func updateWith(viewModel: UserDataViewModel)
}

public struct UserDataViewModel: Model {
    public let username: String
    public let bankBranch: String
    public let bankAccountNumber: String
    public let bankNumber: String
    public let corporateName: String
    
    public init(username: String, bankBranch: String, bankAccountNumber: String, bankNumber: String, corporateName: String) {
        self.username = username
        self.bankBranch = bankBranch
        self.bankAccountNumber = bankAccountNumber
        self.bankNumber = bankNumber
        self.corporateName = corporateName
    }
}
