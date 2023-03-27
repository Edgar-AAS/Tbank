import Foundation
import Data

class LocalFetchData: HttpGetClient {
    public func get(to url: URL, objectCacheKey: String?, completion: @escaping (Result<Data?, HttpError>) -> (Void)) {
        let urlPath = Bundle.main.url(forResource: "userData", withExtension: "json")
        let data = try! Data(contentsOf: urlPath!)
        completion(.success(data))
    }
}
