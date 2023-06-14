import Foundation
import Presentation
import Domain
import Infra

public let makeCardInformationFactory: (UserCard) -> CardInformationViewController = { userCardModel in
    let controller = CardInformationViewController()
    let router = CardInformationRouter(viewController: controller)
    let httpDeleteClient = makeRemoteDeleteService()
    let deleteCard = makeRemoteDeleteDigitalCard(httpClient: httpDeleteClient)
    let presenter = CardInformationPresenter(userCardModel: userCardModel, deleteCard: deleteCard, updateCardView: WeakVarProxy(controller), delegate: WeakVarProxy(controller), router: router)
    controller.presenter = presenter
    return controller
}
