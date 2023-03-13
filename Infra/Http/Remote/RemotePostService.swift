import Foundation
import Data

public class RemotePostService: HttpPostClient {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func post(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HttpError>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = data
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                guard let response = (response as? HTTPURLResponse) else { return
                    completion(.failure(.noConnectivity))
                }
                
                if let data = data {
                    switch response.statusCode {
                    case 204:
                        completion(.success(nil))
                    case 200...299:
                        completion(.success(data))
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
                }
            } else {
                completion(.failure(.noConnectivity))
            }
        }.resume()
    }
} 
