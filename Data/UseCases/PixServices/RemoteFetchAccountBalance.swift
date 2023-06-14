import Foundation
import Domain

public final class RemoteFetchAccountBalance: UpdateBalance {
    private let httpClient: HttpGetClient
    private let url: URL

    public init(httpClient: HttpGetClient, url: URL) {
        self.httpClient = httpClient
        self.url = url
    }
    
    public func fetchBalance(completion: @escaping (Double) -> ()) {
        httpClient.get(to: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                if let model: UserData = data?.toModel(), let balance = model.first?.totalBalance {
                    completion(balance)
                }
            case .failure: return
            }
        }
    }
}
