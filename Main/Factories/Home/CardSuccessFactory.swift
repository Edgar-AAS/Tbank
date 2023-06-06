import Foundation
import Domain
import Data
import Presentation

public let makeCardSuccessFactory: (UserCard) -> CardSuccessViewController = { userCardModel in
    let controller = CardSuccessViewController()
    let router = CardSuccessRouter(viewController: controller, cardInformationFactory: makeCardInformationFactory)
    let presenter = CardSuccessPresenter(router: router, userCardModel: userCardModel)
    controller.presenter = presenter
    return controller
}
