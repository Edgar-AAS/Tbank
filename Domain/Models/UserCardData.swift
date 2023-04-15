import Foundation

public typealias UserCards = [UserCard]

public struct UserCard: Model {
    public let isVirtual: Bool
    public let balance: Double
    public let cardFlag: String
    public let cardTag: Int
    public let cardBrandImageURL: String
    public let cardNumber, cardExpirationDate, cardFunction, cvc: String
    public let id, name: String

    enum CodingKeys: String, CodingKey {
        case isVirtual, balance, cardFlag, cardTag
        case cardBrandImageURL = "cardBrandImageUrl"
        case cardNumber, cardExpirationDate, cardFunction, cvc, id, name
    }

    public init(isVirtual: Bool, balance: Double, cardFlag: String, cardTag: Int, cardBrandImageURL: String, cardNumber: String, cardExpirationDate: String, cardFunction: String, cvc: String, id: String, name: String) {
        self.isVirtual = isVirtual
        self.balance = balance
        self.cardFlag = cardFlag
        self.cardTag = cardTag
        self.cardBrandImageURL = cardBrandImageURL
        self.cardNumber = cardNumber
        self.cardExpirationDate = cardExpirationDate
        self.cardFunction = cardFunction
        self.cvc = cvc
        self.id = id
        self.name = name
    }
}

