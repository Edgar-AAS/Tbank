import Foundation

public protocol ValidateBalance {
    func validate(enteredValue: Double, completion: @escaping (ValidationResponseType) -> Void)
}
