import Foundation
import Domain

class AddAccountSpy: AddAccount {
    private(set) var addAccountModel: AddAccountModel?
    private(set) var emit: ((Result<AccountModel, DomainError>) -> Void)?
    
    func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, DomainError>) -> Void) {
        self.addAccountModel = addAccountModel
        self.emit = completion
    }
    
    func completeWithSuccess(_ success: AccountModel) {
        self.emit?(.success(success))
    }

    func completeWithFailure(_ failure: DomainError) {
        self.emit?(.failure(.unexpected))
    }
}
