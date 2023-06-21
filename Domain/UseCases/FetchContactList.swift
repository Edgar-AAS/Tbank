import Foundation

public protocol FetchContactList {
    typealias Result = Swift.Result<[ContactModel], DomainError>
    func fetch(with query: String, completion: @escaping (FetchContactList.Result) -> Void)
}
