import Foundation
import Domain

class FetchUserDataSpy: FetchUserDataResources {
    private(set) var emit: ((FetchUserDataResources.Result) -> Void)?
    
    func fetch(completion: @escaping (Result<UserData, DomainError>) -> Void) {
        self.emit = completion
    }
    
    func completeWithSuccess(_ success: UserData) {
        self.emit?(.success(success))
    }

    func completeWithFailure(_ failure: DomainError) {
        self.emit?(.failure(failure))
    }
}
    
