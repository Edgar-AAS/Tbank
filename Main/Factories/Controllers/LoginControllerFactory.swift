import Foundation
import Domain
import Validation
import Presentation
import Infra

public func makeLoginViewController(authentication: Authentication) -> LoginViewController {
    let controller = LoginViewController()
    let destinationController = makeHomeViewController()
    let validationComposite = ValidationComposite(validations: makeLoginValidations())
    let router = LoginRouter(viewController: controller, destinationController: destinationController)
    let presenter = LoginPresenter(validation: validationComposite,
                                   alertView: WeakVarProxy(controller),
                                   authentication: authentication,
                                   loadingView: WeakVarProxy(controller),
                                   router: router)
    controller.login = presenter.login
    return controller
}

public func makeLoginValidations() -> [Validation] {
    return [
        RequiredFieldsValidation(fieldName: "email", fieldLabel: "Email"),
        EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: EmailValidatorAdapter()),
        RequiredFieldsValidation(fieldName: "password", fieldLabel: "Senha")
    ]
}


