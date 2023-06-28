import Foundation
import Domain

public class ContactListPresenter {
    private let contactList: FetchContactList
    private weak var dataSource: ContactListDataSource?
    private let router: ContactListRoutingLogic
    private weak var updateBalanceView: UpdateBalanceView?
    private var currencyValue: Double
    
    public init(contactList: FetchContactList,
                dataSource: ContactListDataSource?,
                router: ContactListRoutingLogic,
                updateBalanceView: UpdateBalanceView?,
                currencyValue: Double)
    {
        self.contactList = contactList
        self.dataSource = dataSource
        self.router = router
        self.updateBalanceView = updateBalanceView
        self.currencyValue = currencyValue
    }
}
 
extension ContactListPresenter: ViewToPresentContactList {
    public func updateBalance() {
        updateBalanceView?.update(balance: currencyValue.currencyWith(symbol: .brazilianReal))
    }
    
    public func goToPreTransferScreenWith(contact: ContactModel, valueToTransfer: String) {
        router.routeToPreTransferWith(contact: contact, valueToTransfer: valueToTransfer)
    }
    
    public func fetchListWith(text: String) {
        contactList.fetch(with: text) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let model):
                self?.dataSource?.updateList(list: model)
            case .failure(_): return
            }
        }
    }
}
