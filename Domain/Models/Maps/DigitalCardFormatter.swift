import Foundation

public struct DigitalCardFormatter {
    public let cardNumber: String
    public let cardExpirationDate: String
    public let name: String
    
    public init(cardNumber: String, cardExpirationDate: String, name: String) {
        self.cardNumber = cardNumber
        self.cardExpirationDate = cardExpirationDate
        self.name = name
    }
}
