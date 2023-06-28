import Foundation
import Domain

public class PreTransferPresenter {
    private let valueToTransfer: String
    private weak var updateTransferView: UpdatePreTransferView?
    private let contact: ContactModel
    
    public init(contact: ContactModel, valueToTransfer: String, updateTransferView: UpdatePreTransferView) {
        self.contact = contact
        self.valueToTransfer = valueToTransfer
        self.updateTransferView = updateTransferView
    }
}

//MARK: -- ViewToPresenterPreTransfer
extension PreTransferPresenter: ViewToPresenterPreTransfer {
    public func callsPreTransferData() {
        updateTransferView?.update(contact: contact.getContactModelFormatted, balance: valueToTransfer)
    }
}
