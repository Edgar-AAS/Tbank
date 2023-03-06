import Foundation
import Domain

public final class RemoteAuthentication: Authentication {
    private let url: URL
    private let httpClient: HttpGetClient
    
    public init(url: URL, httpClient: HttpGetClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func auth(authenticationModel: AuthenticationModel, completion: @escaping (Authentication.Result) -> Void) {
        httpClient.get(to: url, completion: { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                if let model: [LoginModel] = data?.toModel() { //um datado invalid nao é conversivel para model
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure(let error):
                switch error {
                case .unauthorized:
                    completion(.failure(.sessionExpired))
                default:
                    completion(.failure(.unexpected))
                }
            }
        })
    }
}
