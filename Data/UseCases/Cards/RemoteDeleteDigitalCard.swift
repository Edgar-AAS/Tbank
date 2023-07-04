import Foundation
import Domain

public final class RemoteDeleteDigitalCard: DeleteDigitalCard {
    public let httpClient: HttpDeleteClient
    public let url: URL
    
    public init(url: URL, httpClient: HttpDeleteClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func deleteDigitalCard(with id: String, completion: @escaping (DeleteDigitalCard.Result) -> Void) {
        httpClient.delete(with: url.appendingPathComponent(id)) { [weak self] result in
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
