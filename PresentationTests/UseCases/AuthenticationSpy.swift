import Foundation
import Domain

class AuthenticationSpy: Authentication {
    private(set) var authenticationModel: AuthenticationModel?
    private(set) var emit: ((Authentication.Result) -> Void)?
    
    func auth(authenticationModel: AuthenticationModel, completion: @escaping (Authentication.Result) -> Void) {
        self.authenticationModel = authenticationModel
        self.emit = completion
    }
    
    func completeWithSuccess(_ success: [LoginModel]) {
        self.emit?(.success(success))
    }

    func completeWithFailure(_ failure: DomainError) {
        self.emit?(.failure(failure))
    }
}
