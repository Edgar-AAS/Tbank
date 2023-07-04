import Foundation

public struct ProfileInfoViewModel {
    public let username: String
    public let bankBranch: String
    public let bankAccountNumber: String
    public let bankNumber: String
    public let corporateName: String
    
    public init(username: String,
                bankBranch: String,
                bankAccountNumber: String,
                bankNumber: String,
                corporateName: String)
    {
        self.username = username
        self.bankBranch = bankBranch
        self.bankAccountNumber = bankAccountNumber
        self.bankNumber = bankNumber
        self.corporateName = corporateName
    }
}

public struct PersonalDataViewModel {
    public let infoName: String
    public let infoValue: String
    
    public init(infoName: String, infoValue: String) {
        self.infoName = infoName
        self.infoValue = infoValue
    }
}
