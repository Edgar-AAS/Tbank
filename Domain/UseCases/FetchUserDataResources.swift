import Foundation

public protocol FetchUserDataResources {
    typealias Result = Swift.Result<[UserModel], DomainError>
    func fetch(completion: @escaping (FetchUserDataResources.Result) -> Void)
}
