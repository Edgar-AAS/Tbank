import Foundation
import Domain

public protocol UpdatePreTransferView: AnyObject {
    func update(viewModel: PreTransferViewModel)
}

public class PreTransferViewModel {
    let balanceToTransfer: String
    let contactName: String
    let cpf: String

    public init(balanceToTransfer: String, contactName: String, cpf: String) {
        self.balanceToTransfer = balanceToTransfer
        self.contactName = contactName
        self.cpf = cpf
    }
}
