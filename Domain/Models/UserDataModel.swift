import Foundation

// MARK: - UserDataModel
public struct UserDataModel: Model {
    public let username: String
    public let totalBalance: Double
    public let balanceIsHidden, isNotifying: Bool
    public let bankBranch, bankAccountNumber, bankNumber, corporateName: String
    public let cards: [Card]
    public let services: [Service]
    public let resources: [Resource]
    public let adresses: [Adress]

    public init(username: String, totalBalance: Double, balanceIsHidden: Bool, isNotifying: Bool, bankBranch: String, bankAccountNumber: String, bankNumber: String, corporateName: String, cards: [Card], services: [Service], resources: [Resource], adresses: [Adress]) {
        self.username = username
        self.totalBalance = totalBalance
        self.balanceIsHidden = balanceIsHidden
        self.isNotifying = isNotifying
        self.bankBranch = bankBranch
        self.bankAccountNumber = bankAccountNumber
        self.bankNumber = bankNumber
        self.corporateName = corporateName
        self.cards = cards
        self.services = services
        self.resources = resources
        self.adresses = adresses
    }
}

// MARK: - Adress
public struct Adress: Model {
    public let street, city, state, number: String
    public let zipCode: String

    public init(street: String, city: String, state: String, number: String, zipCode: String) {
        self.street = street
        self.city = city
        self.state = state
        self.number = number
        self.zipCode = zipCode
    }
}

// MARK: - Card
public struct Card: Model {
    public let isVirtual: Bool
    public let balance: Double
    public let cardFlag: String
    public let cardTag: Int
    public let cardBrandImageURL, cardNumber, cardExpirationDate, cardFunction: String
    public let cvc, id, name: String

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

// MARK: - Resource
public struct Resource: Model {
    public let resourceID, applogoURL, resourceDescription: String

    enum CodingKeys: String, CodingKey {
        case resourceID = "resourceId"
        case applogoURL = "applogoUrl"
        case resourceDescription
    }

    public init(resourceID: String, applogoURL: String, resourceDescription: String) {
        self.resourceID = resourceID
        self.applogoURL = applogoURL
        self.resourceDescription = resourceDescription
    }
}

// MARK: - Service
public struct Service: Model {
    public let iconURL, serviceName: String
    public let serviceTag: Int

    enum CodingKeys: String, CodingKey {
        case iconURL = "iconUrl"
        case serviceName, serviceTag
    }

    public init(iconURL: String, serviceName: String, serviceTag: Int) {
        self.iconURL = iconURL
        self.serviceName = serviceName
        self.serviceTag = serviceTag
    }
}

