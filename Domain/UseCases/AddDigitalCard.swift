import Foundation

public protocol AddCard {
    typealias Result = Swift.Result<Void, DomainError>
    func add<T: Model>(cardModel: T, completion: @escaping (AddCard.Result) -> Void)
}

public struct DigitalCardModel: Model {
    public let name: String
    public let isVirtual: Bool
    public let balance: Double
    public let cardFlag: String
    public let cardBrandImageUrl: String?
    public let cardTag: Int
    public let cardNumber: String
    public let cardExpirationDate: String
    public let cardFunction: String
    public let cvc: String
    
    public init(
        name: String,
        isVirtual: Bool = true,
        balance: Double = 0.0,
        cardFlag: String = "Gold",
        cardTag: Int = 0,
        cardBrandImageUrl: String? = nil,
        cardNumber: String, 
        cardExpirationDate: String,
        cardFunction: String,
        cvc: String
    ) {
        self.name = name
        self.isVirtual = isVirtual
        self.balance = balance
        self.cardFlag = cardFlag
        self.cardTag = cardTag
        self.cardBrandImageUrl = cardBrandImageUrl
        self.cardNumber = cardNumber
        self.cardExpirationDate = cardExpirationDate
        self.cardFunction = cardFunction
        self.cvc = cvc
    }
}
