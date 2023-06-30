import Foundation

public protocol UpdateTransferSuccessView: AnyObject {
    func updateViewWith(viewModel: TransferSuccessViewModel)
}

public struct TransferSuccessViewModel {
    public let balance: String
    public let currentDate: String
    public let currentTime: String
    public let contactName: String
    
    public init(balance: String, currentDate: String, currentTime: String, contactName: String) {
        self.balance = balance
        self.currentDate = currentDate
        self.currentTime = currentTime
        self.contactName = contactName
    }
}
