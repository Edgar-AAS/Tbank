import Foundation
import Domain

public struct CardConfigurationRequest: Model {
    public let name: String?
    
    public init(name: String?) {
        self.name = name
    }
}
