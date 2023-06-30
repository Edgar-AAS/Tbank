import Foundation

public struct PersonHeaderViewModel {
    public let username: String
    public let isNotifying: Bool
    
    public init(username: String, isNotifying: Bool) {
        self.username = username
        self.isNotifying = isNotifying
    }
}

public struct BalanceViewModel {
    public let totalBalance: String
    public let balanceIsHidden: Bool
    
    public init(totalBalance: String, balanceIsHidden: Bool) {
        self.totalBalance = totalBalance
        self.balanceIsHidden = balanceIsHidden
    }
}

public struct CardViewModel {
    public let isVirtual: Bool
    public let balance: String
    public let cardFlag: String
    public let cardTag: Int
    public let cardBrandImageURL, cardNumber, cardExpirationDate, cardFunction: String
    public let cvc, id, name: String
    
    public init(isVirtual: Bool,
                balance: String,
                cardFlag: String,
                cardTag: Int,
                cardBrandImageURL: String,
                cardNumber: String,
                cardExpirationDate: String,
                cardFunction: String,
                cvc: String,
                id: String,
                name: String)
    {
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

public struct ServiceViewModel {
    public let iconURL, serviceName: String
    public let serviceTag: Int
    
    public init(iconURL: String, serviceName: String, serviceTag: Int) {
        self.iconURL = iconURL
        self.serviceName = serviceName
        self.serviceTag = serviceTag
    }
}

public struct ResourceViewModel {
    public let resourceID: String
    public let applogoURL: String
    public let resourceDescription: String
    
    public init(resourceID: String, applogoURL: String, resourceDescription: String) {
        self.resourceID = resourceID
        self.applogoURL = applogoURL
        self.resourceDescription = resourceDescription
    }
}

public enum HomeListCellType {
    case userHeaderCell(PersonHeaderViewModel)
    case balanceCell(BalanceViewModel)
    case cardsCell([CardViewModel])
    case servicesCell([ServiceViewModel])
    case resourcesCell([ResourceViewModel])
}
