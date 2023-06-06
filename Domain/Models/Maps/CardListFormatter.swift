import Foundation

public struct CardInformationFormatter {
    public let name: String
    public let cardFlag: String
    public let cardNumber: String
    public let cardExpirationDate: String
    public let cardFunction: String
    public let cvc: String
    
    public init(name: String, cardFlag: String, cardNumber: String, cardExpirationDate: String, cardFunction: String, cvc: String) {
        self.name = name
        self.cardFlag = cardFlag
        self.cardNumber = cardNumber
        self.cardFunction = cardFunction
        self.cardExpirationDate = cardExpirationDate
        self.cvc = cvc
    }
}
