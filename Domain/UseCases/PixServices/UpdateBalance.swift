import Foundation

public protocol UpdateBalance {
    func fetchBalance(completion: @escaping (Double) -> ())
}
