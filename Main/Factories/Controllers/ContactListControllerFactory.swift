import Foundation
import Domain
import Presentation

func makeContactListControllerFactory(contactList: FetchContactList, currencyValue: Double) -> ContactListToTransferController {
    let controller = ContactListToTransferController()
    let router = ContactListRouter(viewController: controller, preTransferFactory: makePreTransferFactory)
    let presenter = ContactListPresenter(contactList: contactList, dataSource: controller, router: router, updateBalanceView: controller, currencyValue: currencyValue)
    controller.presenter = presenter
    return controller
}
