import Foundation

public struct MainService: Model {
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


