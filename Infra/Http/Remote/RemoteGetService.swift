import Foundation
import Data

public class RemoteGetService: HttpGetClient {
    private let session: URLSession
    private let cacheManager: CacheType
    
    public init(session: URLSession = .shared, cacheManager: CacheType) {
        self.session = session
        self.cacheManager = cacheManager
    }
    
    //verificar se a chave passada e igual a chave recebida
    //se tiver dados em cache nao deve fazer a request
    //caso faça a request, a proxima vez que for chamada deve usar o cache
    
    public func get(to url: URL, completion: @escaping (Result<Data?, HttpError>) -> (Void)) {
        if let cacheData = cacheManager.getCachedObject(forKey: "userData") as? Data {
            print("using cache data")
            completion(.success(cacheData))
            return
        }
        
        session.dataTask(with: url) { (data, response, error) in
            if error == nil {
                guard let response = (response as? HTTPURLResponse) else { return
                    completion(.failure(.noConnectivity))
                }
                
                if let data = data {
                    switch response.statusCode {
                    case 204:
                        completion(.success(nil))
                    case 200...299:
                        self.cacheManager.createCachedObject(data as NSData, forKey: "userData")
                        completion(.success(data))
                    case 401:
                        completion(.failure(.unauthorized)) //**
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
