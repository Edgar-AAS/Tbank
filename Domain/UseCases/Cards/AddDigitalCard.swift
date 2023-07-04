import Foundation

public protocol AddCard {
    typealias Result = Swift.Result<Bool, DomainError>
    func add(cardModel: Card, completion: @escaping (AddCard.Result) -> Void)
}
