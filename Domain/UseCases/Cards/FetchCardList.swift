import Foundation

public protocol FetchCardList {
    typealias Result = Swift.Result<[Card], DomainError>
    func fetch(completion: @escaping (FetchCardList.Result) -> Void)
}
