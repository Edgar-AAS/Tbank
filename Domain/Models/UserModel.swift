import Foundation

public struct UserModel: Model {
    public let username: String
    public let totalBalance: Double
    public let cards: [Card]
    public let userImageUrl: String
    public let balanceIsHidden: Bool
    public let isNotifying: Bool
    public let mainServices: [MainService]
    public let bankBranch: String
    public let bankAccountNumber: String
    public let bankNumber: String
    public let corporateName: String
    
    public init(
        username: String,
        totalBalance: Double,
        cards: [Card],
        userImageUrl: String,
        balanceIsHidden: Bool,
        mainServices: [MainService],
        bankBranch: String,
        bankAccountNumber: String,
        bankNumber: String,
        corporateName: String,
        isNotifying: Bool
    ) {
        self.username = username
        self.totalBalance = totalBalance
        self.cards = cards
        self.userImageUrl = userImageUrl
        self.mainServices = mainServices
        self.bankBranch = bankBranch
        self.balanceIsHidden = balanceIsHidden
        self.bankAccountNumber = bankAccountNumber
        self.bankNumber = bankNumber
        self.corporateName = corporateName
        self.isNotifying = isNotifying
    }
}

public struct Card: Model {
    public let isVirtual: Bool
    public let balance: Double
    public let cardFlag: String
    public let cardBrandImageUrl: String
    public let cardTag: Int
    public let cardNumber: String
    public let cardExpirationDate: String
    public let cardFunction: String
    public let cvc: String
    
    public init(
        isVirtual: Bool,
        balance: Double,
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

public struct MainService: Model {
    public let serviceIconUrl: String
    public let serviceName: String
    public let serviceTag: Int
    
    public init(
        serviceIconUrl: String,
        serviceName: String,
        serviceTag: Int
    ) {
        self.serviceIconUrl = serviceIconUrl
        self.serviceName = serviceName
        self.serviceTag = serviceTag
    }
}
