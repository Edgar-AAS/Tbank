import Foundation

protocol FetchUserDataResources {
    typealias Result = Swift.Result<User, DomainError>
    func fetchUserData(completion: @escaping (FetchUserDataResources.Result) -> Void)
}
