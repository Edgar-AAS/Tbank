import Foundation

public protocol CardsView {
    func updateCardsView(viewModel: CardsViewViewModel)
}

public struct CardsViewViewModel {
    public let cards: [CardModel]
    
    public init(cards: [CardModel]) {
        self.cards = cards
    }
}

public struct CardModel {
    public let isVirtual: Bool
    public let balance: String
    public let cardFlag: String
    public let cardBrandImageUrl: String
    public let cardTag: Int
    public let cardNumber: String
    public let cardExpirationDate: String
    public let cardFunction: String
    public let cvc: String
    
    public init(
        isVirtual: Bool,
        balance: String,
        cardFlag: String,
        cardTag: Int,
        cardBrandImageUrl: String,
        cardNumber: String,
        cardExpirationDate: String,
        cardFunction: String,
        cvc: String
    ) {
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
