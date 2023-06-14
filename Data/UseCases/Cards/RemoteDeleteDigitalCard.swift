import Foundation
import Domain

public final class RemoteDeleteDigitalCard: DeleteDigitalCard {
    public let httpClient: HttpDeleteClient
    
    public init(httpClient: HttpDeleteClient) {
        self.httpClient = httpClient
    }
    
    public func deleteCardWith(url: URL, completion: @escaping (DeleteDigitalCard.Result) -> Void) {
        httpClient.delete(with: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
                case .success:
                    completion(.success(true))
                case .failure:
                    completion(.failure(.unexpected))
            }
        }
    }
}
