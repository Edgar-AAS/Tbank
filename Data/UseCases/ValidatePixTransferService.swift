import Foundation
import Domain

public final class ValidatePixTransferService: ValidateBalance {
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
                if let model: UserData = data?.toModel() {
                    if enteredValue != .zero {
                        if model.first!.totalBalance >= enteredValue {
                            completion(.authorized)
                        } else {
                            completion(.unauthorized)
                        }
                    } else {
                        completion(.zero)
                    }
                }
            case .failure: return
            }
        }
    }
}
