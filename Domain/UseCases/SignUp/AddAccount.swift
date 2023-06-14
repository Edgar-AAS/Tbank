import Foundation

public protocol AddAccount {
    typealias Result = Swift.Result<AccountModel, DomainError>
    func add(addAccountModel: AddAccountModel, completion: @escaping (AddAccount.Result) -> Void)
}

public struct AddAccountModel: Model {
    public let name: String
    public let email: String
    public let password: String
    public let passwordConfirmation: String
    
    public init(name: String, email: String, password: String, passwordConfirmation: String) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}
