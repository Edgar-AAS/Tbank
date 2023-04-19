import Foundation
import Domain
import Data
import Presentation

public let makeCardSuccessFactory: (DigitalCardModel) -> CardSuccessViewController = { digitalCardModel in
    let controller = CardSuccessViewController()
    let router = CardSuccessRouter(viewController: controller, cardInformationFactory: makeCardInformationFactory)
    let presenter = CardSuccessPresenter(router: router, digitalCardModel: digitalCardModel)
    controller.presenter = presenter
    return controller
}
