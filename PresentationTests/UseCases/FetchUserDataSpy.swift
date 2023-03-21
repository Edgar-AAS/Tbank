import Foundation
import Domain

class FetchUserDataSpy: FetchUserDataResources {
    private(set) var emit: ((FetchUserDataResources.Result) -> Void)?
    
    func fetch(completion: @escaping (Result<UserModel, DomainError>) -> Void) {
        self.emit = completion
    }
    
    func completeWithSuccess(_ success: UserModel) {
        self.emit?(.success(success))
    }

    func completeWithFailure(_ failure: DomainError) {
        self.emit?(.failure(failure))
    }
}
    
