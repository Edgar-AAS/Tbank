import Foundation
import Domain

public final class SignUpMapper {
    public static func toAddAccountModel(signUpRequest: SignUpRequest) -> AddAccountModel {
        return AddAccountModel(name: signUpRequest.name!, email: signUpRequest.email!, password: signUpRequest.password!, passwordConfirmation: signUpRequest.passwordConfirmation!)
    }
}
