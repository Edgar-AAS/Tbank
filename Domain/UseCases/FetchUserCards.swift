import Foundation

public protocol FetchUserCards {
    typealias Result = Swift.Result<UserCards, DomainError>
    func fetch(completion: @escaping (FetchUserCards.Result) -> Void)
}
