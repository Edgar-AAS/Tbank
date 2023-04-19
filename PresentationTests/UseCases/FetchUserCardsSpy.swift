import Foundation
import Domain

class FetchUserCardsSpy: FetchUserCards {
    private(set) var emit: ((FetchUserCards.Result) -> Void)?
    
    func fetch(completion: @escaping (Result<UserCards, DomainError>) -> Void) {
        self.emit = completion
    }
    
    func completeWithSuccess(_ success: UserCards) {
        self.emit?(.success(success))
    }

    func completeWithFailure(_ failure: DomainError) {
        self.emit?(.failure(failure))
    }
}
    
