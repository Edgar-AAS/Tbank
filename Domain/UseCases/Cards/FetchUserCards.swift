import Foundation

public protocol FetchUserCards {
    typealias Result = Swift.Result<[Card], DomainError>
    func fetch(completion: @escaping (FetchUserCards.Result) -> Void)
}
