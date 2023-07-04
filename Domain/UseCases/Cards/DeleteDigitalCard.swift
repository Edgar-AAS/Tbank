import Foundation

public protocol DeleteDigitalCard {
    typealias Result = Swift.Result<Bool, DomainError>
    func deleteDigitalCard(with id: String, completion: @escaping (DeleteDigitalCard.Result) -> Void)
}
