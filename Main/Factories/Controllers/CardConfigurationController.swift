import Foundation
import Domain
import Data
import Infra
import Presentation
import Validation

public func makeCardConfigurationController(addCard: AddCard) -> CardConfigurationViewController {
    let controller = CardConfigurationViewController()
    let validationComposite = ValidationComposite(validations: makeAddCardValidations())
    let router = CardConfigurationRouter(viewController: controller, cardSuccessFactory: makeCardSuccessFactory)
    let presenter = CardConfigurationPresenter(validation: validationComposite, addDigitalCard: addCard, alertView: WeakVarProxy(controller), loadingView: WeakVarProxy(controller), router: router)
    controller.createDigitalCard = presenter.createDigitalCard
    return controller
}

public func makeAddCardValidations() -> [Validation] {
    return [
        RequiredFieldsValidation(fieldName: "name", fieldLabel: "de nome do cartão")
    ]
}
