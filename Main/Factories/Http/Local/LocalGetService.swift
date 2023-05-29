import Foundation
import Data

public class LocalFetchData: HttpGetClient {
    public let forResource: String?
    public let withExtension: String?
    
    public init(forResource: String?, withExtension: String?) {
        self.forResource = forResource
        self.withExtension = withExtension
    }
    
    public func get(to url: URL, completion: @escaping (Result<Data?, HttpError>) -> (Void)) {
        let urlPath = Bundle.main.url(forResource: forResource, withExtension: withExtension)
        let data = try! Data(contentsOf: urlPath!)
        completion(.success(data))
    }
}
