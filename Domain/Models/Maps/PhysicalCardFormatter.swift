import Foundation

public struct PhysicalCardFormater {
    public let balance: String
    public let cardNumber: String
    public let expirationDate: String
    
    public init(balance: String, cardNumber: String, expirationDate: String) {
        self.balance = balance
        self.cardNumber = cardNumber
        self.expirationDate = expirationDate
    }
}
