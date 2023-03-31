import Foundation

// MARK: - PersonData
public struct PersonData: Model {
    public let bankBranch, bankAccountNumber, bankNumber, corporateName: String
    public let adresses: [Adress]

    public init(bankBranch: String, bankAccountNumber: String, bankNumber: String, corporateName: String, adresses: [Adress]) {
        self.bankBranch = bankBranch
        self.bankAccountNumber = bankAccountNumber
        self.bankNumber = bankNumber
        self.corporateName = corporateName
        self.adresses = adresses
    }
}

// MARK: - Adress
public struct Adress: Model {
    public let streetAddress, city, state, number: String
    public let zipCode: String

    public init(streetAddress: String, city: String, state: String, number: String, zipCode: String) {
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.number = number
        self.zipCode = zipCode
    }
}
