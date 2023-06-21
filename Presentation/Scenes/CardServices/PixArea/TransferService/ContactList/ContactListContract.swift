import Foundation
import Domain

public protocol ViewToPresentContactList {
    func fetchListWith(text: String)
    func goToPreTransferScreenWith(contact: ContactModel)
    func updateBalance()
}

public protocol ContactListDataSource: AnyObject {
    func updateList(list: [ContactModel])
}

public protocol ContactListRoutingLogic {
    func routeToPreTransferWith(contact: ContactModel)
}
