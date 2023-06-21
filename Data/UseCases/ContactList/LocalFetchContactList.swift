import Foundation
import Domain

final public class LocalFetchContactList: FetchContactList {
    public let httpClient: HttpGetClient
  
    public init(httpClient: HttpGetClient) {
        self.httpClient = httpClient
    }
    
    public func fetch(with query: String, completion: @escaping (FetchContactList.Result) -> Void) {
        httpClient.get(to: nil) { [weak self] result in
            guard self != nil else { return }
            switch result {
                case .success(let data):
                    if let model: [ContactModel] = data?.toModel() {
                        let contacts = model.filter({ $0.name.contains(query) ||
                                                      $0.cpf == query ||
                                                      $0.cnpj == query ||
                                                      $0.email == query ||
                                                      $0.phoneNumber == query })
                        query.isEmpty ? completion(.success(model)) : completion(.success(contacts))
                    }
            case .failure: completion(.failure(.unexpected))
            }
        }
    }
}
