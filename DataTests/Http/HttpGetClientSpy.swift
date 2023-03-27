import Foundation
import Data
import Domain

public class HttpGetClientSpy: HttpGetClient {
    private(set) var urls = [URL]()
    private(set) var completion: ((Result<Data?, HttpError>) -> (Void))?
    private (set) var objectCacheKeyReceived: String?
    
    public func get(to url: URL, objectCacheKey: String?, completion: @escaping (Result<Data?, HttpError>) -> (Void)) {
        self.urls.append(url)
        self.objectCacheKeyReceived = objectCacheKey
        self.completion = completion
    }

    public func completeWithError(_ error: HttpError) {
        completion?(.failure(error))
    }
    
    public func completeWithData(_ data: Data) {
        completion?(.success(data))
    }
}
