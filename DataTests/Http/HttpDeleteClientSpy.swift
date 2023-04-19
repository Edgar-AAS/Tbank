import Foundation
import Data
import Domain

public class HttpDeleteClientSpy: HttpDeleteClient {
    private(set) var urls = [URL]()
    private(set) var completion: ((Result<Bool, HttpError>) -> Void)?
    
    public func delete(with url: URL, completion: @escaping (Result<Bool, HttpError>) -> Void) {
        self.urls.append(url)
        self.completion = completion
    }
    
    public func completeWithError(_ error: HttpError) {
        completion?(.failure(error))
    }
    
    public func completeWithSuccess() {
        completion?(.success(true))
    }
}
