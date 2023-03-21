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
    public let accountNumber: String
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
        accountNumber: String,
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
        self.accountNumber = accountNumber
        self.bankNumber = bankNumber
        self.corporateName = accountNumber
        self.isNotifying = isNotifying
    }
}

public struct Card: Model {
    public let isVirtual: Bool
    public let balance: Double
    public let cardFlag: Int
    public let cardNumber: String
    public let cardExpirationData: String
    public let cardFunction: String
    public let cvc: String
    
    public init(
        isVirtual: Bool,
        balance: Double,
        cardFlag: Int,
        cardNumber: String,
        cardExpirationData: String,
        cardFunction: String,
        cvc: String
    ) {
        self.isVirtual = isVirtual
        self.balance = balance
        self.cardFlag = cardFlag
        self.cardNumber = cardNumber
        self.cardExpirationData = cardExpirationData
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
