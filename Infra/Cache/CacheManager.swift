import Foundation
import Data

public final class CacheManager: CacheType {
    public let cache = NSCache<NSString, AnyObject>()
    
    public init() {}
    
    public func createCachedObject(_ object: AnyObject, forKey key: String) {
        cache.setObject(object, forKey: key as NSString)
    }
    
    public func getCachedObject(forKey key: String) -> AnyObject? {
        cache.object(forKey: key as NSString)
    }
    
    public func removeCachedObject(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
    public func removeAllCachedObjects() {
        cache.removeAllObjects()
    }
}
