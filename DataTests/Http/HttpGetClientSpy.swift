import Foundation
import Data
import Domain

class HttpGetClientSpy: HttpGetClient {
    private(set) var urls = [URL]()
    private(set) var completion: ((Result<Data?, HttpError>) -> (Void))?
    
    func get(to url: URL, completion: @escaping (Result<Data?, HttpError>) -> (Void)) {
        self.urls.append(url)
        self.completion = completion
    }
    
    func completeWithError(_ error: HttpError) {
        completion?(.failure(error))
    }
    
    func completeWithData(_ data: Data) {
        completion?(.success(data))
    }
}
