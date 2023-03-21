import Foundation
import Infra
import Data

class CacheManagerSpy: CacheType {
    func createCachedObject(_ object: AnyObject, forKey key: String) {
        
    }
    
    func getCachedObject(forKey key: String) -> AnyObject? {
        return nil
    }
    
    func removeAllCachedObjects() {
        
    }
    
    func removeCachedObject(forKey key: String) {
        
    }
}
