import Foundation

public struct AccountModel: Model {
    let id: String
    let name: String
    let email: String
    let password: String
    
    public init(id: String, name: String, email: String, password: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
    }
}
