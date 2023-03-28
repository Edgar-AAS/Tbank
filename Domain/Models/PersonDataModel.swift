import Foundation

public struct PersonDataModel: Model {
    public let bankBranch: String
    public let bankAccountNumber: String
    public let bankNumber: String
    public let corporateName: String
    
    public init(bankBranch: String, bankAccountNumber: String, bankNumber: String, corporateName: String) {
        self.bankBranch = bankBranch
        self.bankAccountNumber = bankAccountNumber
        self.bankNumber = bankNumber
        self.corporateName = corporateName
    }
}
