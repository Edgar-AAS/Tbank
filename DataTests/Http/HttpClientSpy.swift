import Foundation
import Data

class HttpClientSpy: HttpPostClient {
    private(set) var urls = [URL]()
    private(set) var data: Data?
    
    func post(to: URL, with data: Data?) {
        self.data = data
        self.urls.append(to)
    }
}
