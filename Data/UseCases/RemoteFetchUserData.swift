import Foundation
import Domain

public class RemoteFetchUserData: FetchUserDataResources {
    private let url: URL
    private let httpGetClient: HttpGetClient
    private let objectCacheKey: String?
    
    public init(url: URL, httpGetClient: HttpGetClient, objectCacheKey: String? = nil) {
        self.url = url
        self.httpGetClient = httpGetClient
        self.objectCacheKey = objectCacheKey
    }
        
    public func fetch(completion: @escaping (FetchUserDataResources.Result) -> Void) {
        httpGetClient.get(to: url, objectCacheKey: objectCacheKey, completion: { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .failure: completion(.failure(.unexpected)) //tratar os outros erros se for necessario
            case .success(let data):
                if let model: UserData = data?.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
            }
        })
    }
}
