import Foundation
import Domain

public final class RemoteValidateBalance: ValidateBalance {
    private let httpClient: HttpGetClient
    private let url: URL
    
    public init(httpClient: HttpGetClient, url: URL) {
        self.httpClient = httpClient
        self.url = url
    }
    
    public func validate(enteredValue: Double, completion: @escaping (ValidationResponseType) -> Void) {
        httpClient.get(to: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                if let model: [ContatcModelElement] = data?.toModel() {
                    if enteredValue != .zero {
                        if let balance = model.first?.totalBalance {
                            if balance >= enteredValue {
                                completion(.authorized)
                            } else {
                                completion(.unauthorized)
                            }
                        }
                    } else { return }
                }
            case .failure: return
            }
        }
    }
}
