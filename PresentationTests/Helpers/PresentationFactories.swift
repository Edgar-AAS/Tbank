import Foundation
import Presentation
import Domain

func makeSignUpRequest(name: String = "any_name", email: String =  "valid_email@gmail.com", password: String = "any_password", passwordConfirmation: String = "any_password") -> SignUpRequest {
    return SignUpRequest(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
}

func makeLoginRequest(email: String =  "valid_email@gmail.com", password: String = "any_password") -> LoginRequest {
    return LoginRequest(email: email, password: password)
}
