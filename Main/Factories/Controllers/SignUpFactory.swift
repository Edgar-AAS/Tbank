import Foundation
import Domain
import UI
import Validation
import Presentation
import Infra

public func makeSignUpController(addAccount: AddAccount) -> SignUpViewController {
    let controller = SignUpViewController()
    let validationComposite = ValidationComposite(validations: makeSignUpValidations())
    let viewModel = SignUpViewModel(alertView: WeakVarProxy(controller), addAccount: addAccount, loadingView: WeakVarProxy(controller), validation: validationComposite)
    controller.signUp = viewModel.signUp
    return controller
}

public func makeLoginViewController() -> LoginViewController {
    return LoginViewController()
}

public func makeSignUpValidations() -> [Validation] {
    return [
        RequiredFieldsValidation(fieldName: "name", fieldLabel: "Nome"),
        RequiredFieldsValidation(fieldName: "email", fieldLabel: "Email"),
        EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorAdapter()),
        RequiredFieldsValidation(fieldName: "password", fieldLabel: "Senha"),
        RequiredFieldsValidation(fieldName: "passwordConfirmation", fieldLabel: "Confirmar Senha"),
        CompareFieldsValidation(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmar Senha")
    ]
}
