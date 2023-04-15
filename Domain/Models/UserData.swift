import Foundation

// MARK: - UserDatum

public typealias UserData = [UserDataModel]

public struct UserDataModel: Model {
    public let username: String
    public let totalBalance: Double
    public let userImageURL: String
    public let balanceIsHidden, isNotifying: Bool
    public let bankBranch, bankAccountNumber, bankNumber, corporateName: String
    public let services: [Service]
    public let resources: [Resource]
    public let adresses: [Adress]

    enum CodingKeys: String, CodingKey {
        case username, totalBalance
        case userImageURL = "userImageUrl"
        case balanceIsHidden, isNotifying, bankBranch, bankAccountNumber, bankNumber, corporateName, services
        case resources = "resources:"
        case adresses
    }

    public init(username: String, totalBalance: Double, userImageURL: String, balanceIsHidden: Bool, isNotifying: Bool, bankBranch: String, bankAccountNumber: String, bankNumber: String, corporateName: String, services: [Service], resources: [Resource], adresses: [Adress]) {
        self.username = username
        self.totalBalance = totalBalance
        self.userImageURL = userImageURL
        self.balanceIsHidden = balanceIsHidden
        self.isNotifying = isNotifying
        self.bankBranch = bankBranch
        self.bankAccountNumber = bankAccountNumber
        self.bankNumber = bankNumber
        self.corporateName = corporateName
        self.services = services
        self.resources = resources
        self.adresses = adresses
    }
}

// MARK: - Adress
public struct Adress: Model {
    public let streetAddress, city, state, number: String
    public let zipCode: String

    public init(streetAddress: String, city: String, state: String, number: String, zipCode: String) {
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.number = number
        self.zipCode = zipCode
    }
}

// MARK: - Resources
public struct Resource: Model {
    public let applogoURL: String
    public let resourceDescription: String
    public let resourceId: String
    
    enum CodingKeys: String, CodingKey {
        case applogoURL = "applogoUrl"
        case resourceDescription, resourceId
    }

    public init(applogoURL: String, resourceDescription: String, resourceId: String) {
        self.applogoURL = applogoURL
        self.resourceDescription = resourceDescription
        self.resourceId = resourceId
    }
}

// MARK: - Service
public struct Service: Model {
    public let serviceIconURL, serviceName: String
    public let serviceTag: Int

    enum CodingKeys: String, CodingKey {
        case serviceIconURL = "serviceIconUrl"
        case serviceName, serviceTag
    }

    public init(serviceIconURL: String, serviceName: String, serviceTag: Int) {
        self.serviceIconURL = serviceIconURL
        self.serviceName = serviceName
        self.serviceTag = serviceTag
    }
}

