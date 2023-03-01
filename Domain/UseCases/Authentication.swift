import Foundation

protocol Authentication {
    func auth(authenticationModel: AuthenticationModel, completion: @escaping (AddAccount.Result) -> Void)
}

public struct AuthenticationModel {
    private let email: String
    private let password: String

    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
