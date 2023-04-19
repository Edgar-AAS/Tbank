import Foundation
import Data

public class RemoteDeleteService: HttpDeleteClient {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func delete(with url: URL, completion: @escaping (Result<Bool, HttpError>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                guard let response = (response as? HTTPURLResponse) else { return
                    completion(.failure(.noConnectivity))
                }
                
                switch response.statusCode {
                    case 200...299:
                        completion(.success(true))
                    case 401:
                        completion(.failure(.unauthorized))
                    case 403:
                        completion(.failure(.forbidden))
                    case 400...499:
                        completion(.failure(.badRequest))
                    case 500...599:
                        completion(.failure(.serverError))
                    default:
                        completion(.failure(.noConnectivity))
                }
            } else {
                completion(.failure(.noConnectivity))
            }
        }.resume()
    }
}
