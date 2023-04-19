import Foundation

public protocol HttpDeleteClient {
    func delete(with url: URL, completion: @escaping (Result<Bool, HttpError>) -> Void)
}
