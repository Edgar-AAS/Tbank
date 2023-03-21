import Foundation
import Domain

public struct LoginRequest: Model {
    public var email: String?
    public var password: String?
    
    public init(email: String? = nil, password: String? = nil) {
        self.email = email
        self.password = password
    }
    
    public func toAuthenticationModel() -> AuthenticationModel {
        return AuthenticationModel(email: email!, password: password!)
    }
    
//    public static func == (lhs: LoginRequest, rhs: LoginModel) -> Bool {
//        return lhs.email == rhs.password && lhs.email == rhs.password
//    }
}
