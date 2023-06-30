import Foundation
import Domain

public class TransferSuccessPresenter {
    let date = Date()
    let calendar = Calendar.current
    
    private weak var updateTransferView: UpdateTransferSuccessView?
    private let contact: ContactToTransferModel
    private let router: TransferSuccessRoutingLogic
    
    public init(contact: ContactToTransferModel, updateTransferView: UpdateTransferSuccessView, router: TransferSuccessRoutingLogic) {
        self.contact = contact
        self.updateTransferView = updateTransferView
        self.router = router
    }
    
    var currentDate: String {
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        let date = "\(day)/\(month)/\(year)"
        return date
    }
    
    var currentTime: String {
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let time = "\(hour):\(minutes)"
        return time
    }
}

extension TransferSuccessPresenter: ViewToPresenterTransferSuccess {
    public func goToPixArea() {
        router.routeToPixArea()
    }
        
    public func updateUI() {
        let viewModel = TransferSuccessViewModel(balance: contact.balanceToTransfer,
                                                 currentDate: currentDate,
                                                 currentTime: currentTime,
                                                 contactName: contact.contactName)
        updateTransferView?.updateViewWith(viewModel: viewModel)
    }
}
