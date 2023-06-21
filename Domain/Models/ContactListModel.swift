import Foundation

public struct ContactModel: Model {
    public let name, cpf, cnpj, email: String
    public let phoneNumber: String
    
    public init(name: String, cpf: String, cnpj: String, email: String, phoneNumber: String) {
        self.name = name
        self.cpf = cpf
        self.cnpj = cnpj
        self.email = email
        self.phoneNumber = phoneNumber
    }
}
