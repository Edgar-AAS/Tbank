import Foundation

public protocol FetchUserDataResources {
    typealias Result = Swift.Result<UserDataModel, DomainError>
    func fetch(completion: @escaping (FetchUserDataResources.Result) -> Void)
}
