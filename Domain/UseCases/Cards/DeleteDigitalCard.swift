import Foundation

public protocol DeleteDigitalCard {
    typealias Result = Swift.Result<Bool, DomainError>
    func deleteCardWith(url: URL, completion: @escaping (DeleteDigitalCard.Result) -> Void)
}
