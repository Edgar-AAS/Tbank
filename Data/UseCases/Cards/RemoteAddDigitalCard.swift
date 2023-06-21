import Foundation
import Domain

public final class RemoteAddDigitalCard: AddCard {
    private let url: URL
    private let httpClient: HttpPostClient
    
    public init(url: URL, httpClient: HttpPostClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func add(cardModel: UserCard, completion: @escaping (Result<Bool, DomainError>) -> Void) {
        httpClient.post(to: url, with: cardModel.toData()) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                switch error {
                case .unauthorized:
                    completion(.failure(.sessionExpired))
                default:
                    completion(.failure(.unexpected))
                }
            }
        }
    }
}
