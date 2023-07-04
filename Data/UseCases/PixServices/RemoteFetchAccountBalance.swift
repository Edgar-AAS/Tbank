import Foundation
import Domain

public final class RemoteFetchAccountBalance: FetchBalance {
    private let httpClient: HttpGetClient
    private let url: URL

    public init(httpClient: HttpGetClient, url: URL) {
        self.httpClient = httpClient
        self.url = url
    }
    
    public func fetch(completion: @escaping (Double) -> ()) {
        httpClient.get(to: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data): break
//                if let model: UserDataModel = data?.toModel() {
//                    completion(model.totalBalance)
//                }
            case .failure: return
            }
        }
    }
}
