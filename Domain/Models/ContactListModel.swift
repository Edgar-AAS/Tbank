import Foundation

public struct ContactModel: Codable {
    public let name, cpf, cnpj, email: String
    public let phoneNumber, bankAccountNumber, bankBranch: String

    public init(name: String, cpf: String, cnpj: String, email: String, phoneNumber: String, bankAccountNumber: String, bankBranch: String) {
        self.name = name
        self.cpf = cpf
        self.cnpj = cnpj
        self.email = email
        self.phoneNumber = phoneNumber
        self.bankAccountNumber = bankAccountNumber
        self.bankBranch = bankBranch
    }
}
