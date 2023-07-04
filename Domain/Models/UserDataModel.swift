// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let contatcModel = try? JSONDecoder().decode(ContatcModel.self, from: jsonData)

import Foundation


public typealias UserData = [ContatcModelElement]

// MARK: - ContatcModelElement
public struct ContatcModelElement: Model {
    public let username: String
    public let totalBalance: Double
    public let balanceIsHidden, isNotifying: Bool
    public let bankBranch, bankAccountNumber, bankNumber, corporateName: String
    public let adresses: [Adress]
    public let services: [Service]
    public let resources: [Resource]
    public let id: String
    public let cards: [Card]

    public init(username: String, totalBalance: Double, balanceIsHidden: Bool, isNotifying: Bool, bankBranch: String, bankAccountNumber: String, bankNumber: String, corporateName: String, adresses: [Adress], services: [Service], resources: [Resource], id: String, cards: [Card]) {
        self.username = username
        self.totalBalance = totalBalance
        self.balanceIsHidden = balanceIsHidden
        self.isNotifying = isNotifying
        self.bankBranch = bankBranch
        self.bankAccountNumber = bankAccountNumber
        self.bankNumber = bankNumber
        self.corporateName = corporateName
        self.adresses = adresses
        self.services = services
        self.resources = resources
        self.id = id
        self.cards = cards
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
    public let cvc, name, id, userID: String

    enum CodingKeys: String, CodingKey {
        case isVirtual, balance, cardFlag, cardTag
        case cardBrandImageURL = "cardBrandImageUrl"
        case cardNumber, cardExpirationDate, cardFunction, cvc, name, id
        case userID = "userId"
    }

    public init(isVirtual: Bool, balance: Double, cardFlag: String, cardTag: Int, cardBrandImageURL: String, cardNumber: String, cardExpirationDate: String, cardFunction: String, cvc: String, name: String, id: String, userID: String) {
        self.isVirtual = isVirtual
        self.balance = balance
        self.cardFlag = cardFlag
        self.cardTag = cardTag
        self.cardBrandImageURL = cardBrandImageURL
        self.cardNumber = cardNumber
        self.cardExpirationDate = cardExpirationDate
        self.cardFunction = cardFunction
        self.cvc = cvc
        self.name = name
        self.id = id
        self.userID = userID
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

