import Foundation

public struct ProfileInfoModel {
    public let userName: String
    public let bankBranch: String
    public let bankAccountNumber: String
    public let bankNumber: String
    public let corporateName: String
    
    public init(userName: String,
                bankBranch: String,
                bankAccountNumber: String,
                bankNumber: String,
                corporateName: String)
    {
        self.userName = userName
        self.bankBranch = bankBranch
        self.bankAccountNumber = bankAccountNumber
        self.bankNumber = bankNumber
        self.corporateName = corporateName
    }
}
