import Foundation
import Presentation
import Domain
import Infra

public let makeCardInformationFactory: (DigitalCardModel) -> CardInformationViewController = { digitalCardModel in
    let controller = CardInformationViewController()
    let router = CardInformationRouter(viewController: controller)
    let httpDeleteClient = makeRemoteDeleteService()
    let deleteCard = makeRemoteDeleteDigitalCard(httpClient: httpDeleteClient)
    let presenter = CardInformationPresenter(digitalCardModel: digitalCardModel, deleteCard: MainQueueDispatchDecorator(deleteCard), updateCardView: WeakVarProxy(controller), delegate: WeakVarProxy(controller), router: router)
    controller.presenter = presenter
    return controller
}
