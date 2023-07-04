import Foundation
import Domain

public class RemoteFetchCards: FetchCardList {
    private let url: URL
    private let httpGetClient: HttpGetClient

    public init(url: URL, httpGetClient: HttpGetClient) {
        self.url = url
        self.httpGetClient = httpGetClient
    }

    public func fetch(completion: @escaping (FetchCardList.Result) -> Void) {
        httpGetClient.get(to: url, completion: { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .failure: completion(.failure(.unexpected))
            case .success(let data):
                if let model: [Card] = data?.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
            }
        })
    }
}
