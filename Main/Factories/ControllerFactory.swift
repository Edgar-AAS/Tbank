import Foundation
import Domain
import UI
import Presentation
import Validation
import Infra
import Data

final class ControllerFactory {
    static func makeSignUpController(addAccount: AddAccount) -> SignUpViewController {
        let controller = SignUpViewController()
        let emailValidatorAdapter = EmailValidtorAdapter()
        let viewModel = SignUpViewModel(alertView: WeakVarProxy(controller), emailValidator: emailValidatorAdapter, addAccount: addAccount, loadingView: WeakVarProxy(controller))
        controller.signUp = viewModel.signUp
        return controller
    }
}
