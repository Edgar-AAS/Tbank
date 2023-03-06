import Foundation

public protocol Authentication {
    typealias Result = Swift.Result<[LoginModel], DomainError>
    func auth(authenticationModel: AuthenticationModel, completion: @escaping (Authentication.Result) -> Void)
}

public struct AuthenticationModel: Model {
    private let email: String
    private let password: String

    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
