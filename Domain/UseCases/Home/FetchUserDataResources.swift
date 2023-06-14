import Foundation

public protocol FetchUserDataResources {
    typealias Result = Swift.Result<UserData, DomainError>
    func fetch(completion: @escaping (FetchUserDataResources.Result) -> Void)
}
