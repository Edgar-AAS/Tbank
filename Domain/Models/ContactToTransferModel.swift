import Foundation

public class ContactToTransferModel {
    public let balanceToTransfer: String
    public let contactName: String
    public let cpf: String
    
    public init(balanceToTransfer: String, contactName: String, cpf: String) {
        self.balanceToTransfer = balanceToTransfer
        self.contactName = contactName
        self.cpf = cpf
    }
}
