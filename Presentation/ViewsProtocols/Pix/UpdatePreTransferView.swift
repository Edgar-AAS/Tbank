import Foundation
import Domain

public protocol UpdatePreTransferView: AnyObject {
    func update(contact: ContactModel, balance: String)
}
