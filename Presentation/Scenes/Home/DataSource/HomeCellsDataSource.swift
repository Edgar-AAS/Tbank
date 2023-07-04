import Foundation
import Domain

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
    case cardsCell([Card])
    case servicesCell([ServiceViewModel])
    case resourcesCell([ResourceViewModel])
}
