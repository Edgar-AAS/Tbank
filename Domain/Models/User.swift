import Foundation

public struct User: Model {
    let username: String
    let totalBalance: Double
    let cards: [Card]
    let userImageUrl: String
    let balanceIsHidden: Bool
    let mainServices: [MainService]
    let bankBranch: String
    let accountNumber: String
    let bankNumber: String
    let corporateName: String
    
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
        corporateName: String
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
    }
}

public struct Card: Model {
    let isVirtual: Bool
    let balance: Double
    let cardFlag: Int
    let cardNumber: String
    let cardExpirationData: String
    let cardFunction: String
    let cvc: String
    
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
    let serviceIconUrl: String
    let serviceName: String
    let serviceTag: Int
    
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
