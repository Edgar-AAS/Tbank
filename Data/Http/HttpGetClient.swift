import Foundation

public protocol HttpGetClient {
    func get(to url: URL, objectCacheKey: String?, completion: @escaping (Result<Data?, HttpError>) -> (Void))
}
