import Foundation

public protocol FetchBalance {
    func fetch(completion: @escaping (Double) -> ())
}
