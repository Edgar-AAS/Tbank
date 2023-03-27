import Foundation
import Infra
import Data

class CacheManagerSpy: CacheType {
    private(set) var objectCreationKey: String?
    private(set) var objectRescueKey: String?
    private(set) var createdObjects = [AnyObject]()
    
    //criando com a chave correta
    //criando o objeto correto
    //removendo o correto
    //pegando o correto
    
    func createCachedObject(_ object: AnyObject, forKey key: String) {
        self.objectCreationKey = key
        self.createdObjects.append(object)
    }
    
    func getCachedObject(forKey key: String) -> AnyObject? {
        self.objectRescueKey = key
        return nil
    }
    
    func removeAllCachedObjects() {}
    func removeCachedObject(forKey key: String) {}
}
